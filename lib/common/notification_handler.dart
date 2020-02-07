import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> onBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
   // NotificationHandler.showNotification(message);
  }

  return Future<void>.value();
}

class NotificationHandler {
  FirebaseMessaging _fcm = FirebaseMessaging();

  static final NotificationHandler _singleton = NotificationHandler._internal();
  factory NotificationHandler() {
    return _singleton;
  }

  NotificationHandler._internal();
  BuildContext myContext;

  initializeFCMNotification(BuildContext context) async {
    myContext = context;

    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        //showNotification(message);
      },
      onBackgroundMessage: onBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
    );
  }

  Future onSelectNotification(String payload) async {}

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {}

  getUserToken(Function(String) token) {
    _fcm.getToken().then((newToken) {
      debugPrint("Token: "+ newToken);
      token(newToken);
    });
  }

  static void showNotification(Map<String, dynamic> message) async {
    String title = message["data"]["title"];
    String msg = message["data"]["message"];

    var mMessage = Person(
        name: title,
        key: '1');

    var messageStyle = MessagingStyleInformation(mMessage,
        messages: [Message(msg, DateTime.now(), mMessage)]);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '12', 'Genaral', 'Late Box App Notf.',
        style: AndroidNotificationStyle.Messaging,
        styleInformation: messageStyle,
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);


    await flutterLocalNotificationsPlugin.show(
        0, title, msg, platformChannelSpecifics,
        payload: jsonEncode(message));
  }

}
