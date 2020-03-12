import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_handler.dart';

class ScheduleNotificationManager {
  static final ScheduleNotificationManager _singleton =
      ScheduleNotificationManager._internal();

  factory ScheduleNotificationManager() {
    return _singleton;
  }

  ScheduleNotificationManager._internal();

  Future<void> dailyNotification(Time dailyTime) async {
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1',
      'daily',
      'daily alarm',
      icon: 'app_icon',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Daily Alarm!',
        'Your starting daily now!',
        dailyTime,
        platformChannelSpecifics);
  }
}
