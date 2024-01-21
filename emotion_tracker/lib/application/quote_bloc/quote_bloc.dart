import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
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
          //TODO: boşsa ne olacak?
          if (quote.isEmpty) {
          } else {
            quote.shuffle();
            final failureOrImage = await _quoteRepository.getImage(
              searchKey: quote[0].author.replaceAll(" ", "%20"),
            );
            failureOrImage.fold((failure) {}, (image) {
              emit(state.copyWith(imageUrl: image));
            });
            emit(state.copyWith(optionQuote: Some(quote[0])));
          }
        });
      }
    });
  }
}
