import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:emotion_tracker/domain/emotion_record.dart';
import 'package:emotion_tracker/infrastructure/storage/history_storage.dart';
import 'package:equatable/equatable.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final EmotionHistoryStorage _emotionHistoryStorage;
  HistoryBloc(this._emotionHistoryStorage) : super(HistoryState.initial()) {
    on<HistoryEvent>((event, emit) async {
      if (event is GetHistoryEvent) {
        emit(HistoryState.initial());
        final emotionRecordList = await _emotionHistoryStorage.getHistory();
        if (emotionRecordList == null) {
          emit(state.copyWith(failure: true));
        } else {
          emit(state.copyWith(optionEmotionRecord: Some(emotionRecordList)));
        }
      }
    });
  }
}
