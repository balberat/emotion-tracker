import 'dart:async';

import 'package:emotion_tracker/emotion_tracker.dart';
import 'package:emotion_tracker/injection.dart';
import 'package:emotion_tracker/service/notification_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    await NotificationService.inititializeNotification();
    await setupInjection();
    runApp(const EmotionTracker());
  }, (error, stack) {});
}
