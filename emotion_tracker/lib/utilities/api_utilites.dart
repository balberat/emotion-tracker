import 'dart:convert';
import 'dart:typed_data';

import 'package:emotion_tracker/failure.dart';

Map<String, dynamic> decodeResponseBody(Uint8List bodyBytes) {
  return json.decode(utf8.decode(bodyBytes)) as Map<String, dynamic>;
}

RepositoryFailure? handleGeneralErrors(
    int statusCode, Map<String, dynamic> result) {
  if (statusCode == 200 || statusCode == 201) return null;

  final message = result['error'];

  if (statusCode == 500) {
    return const RepositoryInternalErrorFailure();
  } else if (statusCode == 400) {
    return const RepositoryBadRequestErrorFailure();
  } else if (statusCode == 403) {
    return const RepositoryForbiddenErrorFailure();
  } else if (statusCode == 404) {
    return const RepositoryNotFoundErrorFailure();
  } else {
    if (message != null) {
      return RepositoryUnknownFailure(message);
    } else {
      return const RepositoryUnknownFailure(null);
    }
  }
}
