part of 'quote_bloc.dart';

class QuoteState extends Equatable {
  final Option<Quote> optionQuote;
  final Option<RepositoryFailure> optionFailure;
  const QuoteState({required this.optionQuote, required this.optionFailure});

  @override
  List<Object> get props => [optionQuote, optionFailure];

  QuoteState copyWith({
    Option<Quote>? optionQuote,
    Option<RepositoryFailure>? optionFailure,
  }) {
    return QuoteState(
      optionQuote: optionQuote ?? this.optionQuote,
      optionFailure: optionFailure ?? this.optionFailure,
    );
  }

  factory QuoteState.initial() {
    return const QuoteState(
      optionQuote: None(),
      optionFailure: None(),
    );
  }
}
