part of 'history_bloc.dart';

class HistoryState extends Equatable {
  final Option<List<EmotionRecord>> optionEmotionRecord;
  final bool failure;

  const HistoryState({
    required this.optionEmotionRecord,
    required this.failure,
  });

  @override
  List<Object> get props => [optionEmotionRecord, failure];

  HistoryState copyWith({
    Option<List<EmotionRecord>>? optionEmotionRecord,
    bool? failure,
  }) {
    return HistoryState(
      optionEmotionRecord: optionEmotionRecord ?? this.optionEmotionRecord,
      failure: failure ?? this.failure,
    );
  }

  factory HistoryState.initial() {
    return const HistoryState(
      optionEmotionRecord: None(),
      failure: false,
    );
  }
}
