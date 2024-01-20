import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
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
        final failureOrQuote =
            await _quoteRepository.getQuote(searchKey: event.emotion);
        failureOrQuote.fold((failure) {
          emit(state.copyWith(optionFailure: Some(failure)));
        }, (quote) {
          emit(state.copyWith(optionQuote: Some(quote)));
        });
      }
    });
  }
}
