part of 'quote_bloc.dart';

class QuoteState extends Equatable {
  final Option<Quote> optionQuote;
  final Option<RepositoryFailure> optionFailure;
  final String imageUrl;
  const QuoteState({
    required this.optionQuote,
    required this.optionFailure,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [optionQuote, optionFailure, imageUrl];

  QuoteState copyWith({
    Option<Quote>? optionQuote,
    Option<RepositoryFailure>? optionFailure,
    String? imageUrl,
  }) {
    return QuoteState(
      optionQuote: optionQuote ?? this.optionQuote,
      optionFailure: optionFailure ?? this.optionFailure,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory QuoteState.initial() {
    return const QuoteState(
      optionQuote: None(),
      optionFailure: None(),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Sixteen_faces_expressing_the_human_passions._Wellcome_L0068375_%28cropped%29.jpg/400px-Sixteen_faces_expressing_the_human_passions._Wellcome_L0068375_%28cropped%29.jpg",
    );
  }
}
