part of 'history_bloc.dart';

class HistoryState extends Equatable {
  final Option<List<EmotionRecord>> optionEmotionRecord;
  final bool failure;
  final Option<Emotion> optionEmotion;

  const HistoryState({
    required this.optionEmotionRecord,
    required this.failure,
    required this.optionEmotion,
  });

  @override
  List<Object> get props => [optionEmotionRecord, failure, optionEmotion];

  HistoryState copyWith({
    Option<List<EmotionRecord>>? optionEmotionRecord,
    bool? failure,
    Option<Emotion>? optionEmotion,
  }) {
    return HistoryState(
      optionEmotionRecord: optionEmotionRecord ?? this.optionEmotionRecord,
      failure: failure ?? this.failure,
      optionEmotion: optionEmotion ?? this.optionEmotion,
    );
  }

  factory HistoryState.initial() {
    return const HistoryState(
      optionEmotionRecord: None(),
      optionEmotion: None(),
      failure: false,
    );
  }
}
