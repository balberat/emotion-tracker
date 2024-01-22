import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:emotion_tracker/domain/emotion_record.dart';
import 'package:emotion_tracker/infrastructure/contoller/notification_controller.dart';
import 'package:emotion_tracker/infrastructure/storage/history_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final EmotionHistoryStorage _emotionHistoryStorage;
  final SharedPreferences _sharedPreferences;
  final NotificationController _notificationController;
  HistoryBloc(this._emotionHistoryStorage, this._sharedPreferences,
      this._notificationController)
      : super(HistoryState.initial()) {
    on<HistoryEvent>((event, emit) async {
      if (event is GetHistoryEvent) {
        emit(HistoryState.initial());
        final emotionRecordList = await _emotionHistoryStorage.getHistory();
        if (emotionRecordList == null) {
          emit(state.copyWith(failure: true));
        } else {
          emit(state.copyWith(optionEmotionRecord: Some(emotionRecordList)));
        }
      } else if (event is AddItemToHistoryEvent) {
        emit(HistoryState.initial());
        final now = DateTime.now();
        await _emotionHistoryStorage.insert(EmotionRecord(
          id: -1,
          emotion: event.emotion,
          createDate: now,
        ));
        emit(state.copyWith(optionEmotion: Some(event.emotion)));
        final isNotificationScheduled =
            _sharedPreferences.getBool('notification_scheduled') ?? false;
        if (!isNotificationScheduled) {
          await _sharedPreferences.setBool('notification_scheduled', true);
          await _notificationController.cancelScheduledNotifications();
          await _notificationController.sendPeriodicNotification();
        }
      }
    });
  }
}
