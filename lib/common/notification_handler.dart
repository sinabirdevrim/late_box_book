import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);


    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        showNotification(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
    );
  }

  Future onSelectNotification(String payload) async {

  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {}


  static Future<void> myBackgroundMessageHandler(Map<String, dynamic> message) {
   // showNotification(message);
    return Future<void>.value();
  }

  getUserToken(Function(String) token) {
    _fcm.onTokenRefresh.listen((newToken) {
      token(newToken);
    });
  }

  static void showNotification(Map<String, dynamic> message) async {

    String title = message["data"]["title"];
    String msg = message["data"]["message"];

    var mMessage = Person(
        name: title,
        key: '1',
        //icon: userURLPath,
        iconSource: IconSource.FilePath);
    var messageStyle = MessagingStyleInformation(mMessage,
        messages: [Message(msg, DateTime.now(), mMessage)]);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '1', 'Genaral', 'Late Box App Notf.',
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
