import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:emotion_tracker/constants/emotion_synonyms.dart';
import 'package:emotion_tracker/domain/emotion_record.dart';
import 'package:emotion_tracker/domain/quote.dart';
import 'package:emotion_tracker/failure.dart';
import 'package:emotion_tracker/infrastructure/repository/quote_repository.dart';
import 'package:equatable/equatable.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository _quoteRepository;
  QuoteBloc(this._quoteRepository) : super(QuoteState.initial()) {
    on<QuoteEvent>((event, emit) async {
      if (event is GetQuoteEvent) {
        emit(QuoteState.initial());
        final failureOrQuote =
            await _quoteRepository.getQuote(searchKey: event.emotion.value);
        await failureOrQuote.fold((failure) {
          emit(state.copyWith(optionFailure: Some(failure)));
        }, (quote) async {
          if (quote.isEmpty) {
            final newEmotion = getSynonymEmotion(event.emotion);

            final failureOrQuote = await _quoteRepository.getQuote(
              searchKey: newEmotion.value,
            );

            await failureOrQuote.fold((failure) {
              emit(state.copyWith(optionFailure: Some(failure)));
            }, (quote) async {
              if (quote.isNotEmpty) {
                await updateQuoteAndImage(emit, quote);
              }
            });
          } else {
            await updateQuoteAndImage(emit, quote);
          }
        });
      }
    });
  }
  Emotion getSynonymEmotion(Emotion emotion) {
    final List<String> newEmotions = emotionSynonymsMap[emotion.value];
    newEmotions.shuffle();
    final newEmotion = newEmotions[0];
    return Emotion.fromValue(newEmotion);
  }

  Future<void> updateQuoteAndImage(
    Emitter<QuoteState> emit,
    List<Quote> quote,
  ) async {
    quote.shuffle();
    final failureOrImage = await _quoteRepository.getImage(
      searchKey: quote[0].author.replaceAll(" ", "%20"),
    );
    failureOrImage.fold(
      (_) {},
      (image) {
        emit(state.copyWith(imageUrl: image, optionQuote: Some(quote[0])));
      },
    );
  }
}
