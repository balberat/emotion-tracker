import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationController {
  Future<void> sendPeriodicNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: UniqueKey().hashCode,
        channelKey: 'periodic_channel',
        title:
            '${Emojis.smile_face_with_tears_of_joy + Emojis.smile_smiling_face_with_hearts + Emojis.smile_unamused_face} How are you feeling?',
        body: 'Would you like to see a quote?',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'hope',
          label: 'Hope',
        ),
        NotificationActionButton(
          key: 'anger',
          label: 'Anger',
        ),
        NotificationActionButton(
          key: 'amusement',
          label: 'Amusement',
        ),
        NotificationActionButton(
          key: 'awe',
          label: 'Awe',
        ),
        NotificationActionButton(
          key: 'gratitude',
          label: 'Gratitude',
        ),
        NotificationActionButton(
          key: 'satisfaction',
          label: 'Satisfaction',
        ),
        NotificationActionButton(
          key: 'anxiety',
          label: 'Anxiety',
        ),
        NotificationActionButton(
          key: 'contempt',
          label: 'Contempt',
        ),
        NotificationActionButton(
          key: 'disgust',
          label: 'Disgust',
        ),
        NotificationActionButton(
          key: 'more',
          label: 'Show More...',
        ),
      ],
      schedule: NotificationInterval(
        interval: 300,
        repeats: true,
      ),
    );
  }

  Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}
