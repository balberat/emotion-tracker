part of 'quote_bloc.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object> get props => [];
}

class GetQuoteEvent extends QuoteEvent {
  final Emotion emotion;

  const GetQuoteEvent(this.emotion);
}
