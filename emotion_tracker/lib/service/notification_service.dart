import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:emotion_tracker/application/history_bloc/history_bloc.dart';
import 'package:emotion_tracker/domain/emotion_record.dart';
import 'package:emotion_tracker/emotion_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationService {
  static Future<void> inititializeNotification() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'periodic_channel_group',
          channelKey: 'periodic_channel',
          channelName: 'Periodic notifications',
          channelDescription: 'Notification channel for periodic tests',
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'periodic_channel_group',
            channelGroupName: 'Periodic group')
      ],
      debug: true,
    );

    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.buttonKeyPressed == 'more' ||
        receivedAction.buttonKeyPressed == '') {
      EmotionTracker.navigatorKey.currentState?.pushReplacementNamed('/');
    } else {
      BlocProvider.of<HistoryBloc>(EmotionTracker.navigatorKey.currentContext!)
          .add(
        AddItemToHistoryEvent(
          Emotion.fromValue(receivedAction.buttonKeyPressed),
        ),
      );
      EmotionTracker.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/quote',
        (route) => (route.settings.name != '/quote') || route.isFirst,
        arguments: receivedAction.buttonKeyPressed,
      );
    }
  }
}
