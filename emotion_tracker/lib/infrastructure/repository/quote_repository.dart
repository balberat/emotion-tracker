import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:emotion_tracker/domain/quote.dart';
import 'package:emotion_tracker/environment_variables.dart' as env;
import 'package:emotion_tracker/failure.dart';
import 'package:emotion_tracker/utilities/api_utilites.dart';
import 'package:http/http.dart' as http;

class QuoteRepository {
  final http.Client _client;

  QuoteRepository(this._client);

  Future<Either<RepositoryFailure, List<Quote>>> getQuote({
    required String searchKey,
  }) async {
    try {
      late http.Response response;
      response = await _client.get(
        Uri.parse("${env.QUOTE_CALLBACK_URL}?filter=$searchKey"),
        headers: {"Authorization": "Token token=${env.USER_TOKEN}"},
      );

      final result = decodeResponseBody(response.bodyBytes);

      final generalFailure = handleGeneralErrors(response.statusCode, result);

      if (generalFailure != null) return left(generalFailure);

      final List<Quote> quotes = [];

      for (var i = 0; i < result["quotes"].length; i++) {
        quotes.add(Quote.fromMap(result["quotes"][i]));
      }
      return right(quotes);
    } on SocketException catch (_) {
      return left(const RepositoryConnectionFailure());
    } catch (e) {
      return left(RepositoryUnknownFailure(e.toString()));
    }
  }

  Future<Either<RepositoryFailure, String>> getImage({
    required String searchKey,
  }) async {
    try {
      late http.Response response;
      response = await _client.get(
        Uri.parse("${env.IMAGE_CALLBACK_URL}$searchKey&format=json"),
      );

      final result = decodeResponseBody(response.bodyBytes);

      final generalFailure = handleGeneralErrors(response.statusCode, result);

      if (generalFailure != null) return left(generalFailure);

      var res = result["query"]["pages"];
      res = res[res.keys.first];
      final imglink = res["thumbnail"]["source"];

      return right(imglink);
    } on SocketException catch (_) {
      return left(const RepositoryConnectionFailure());
    } catch (e) {
      return left(RepositoryUnknownFailure(e.toString()));
    }
  }
}
