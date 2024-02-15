

import 'dart:convert';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:full_workout/constants/constant.dart';

import '../main.dart';
import '../pages/main_page.dart';

class FirebaseNotificationHelper {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static  final _androidChannel =  AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used fro important notification',
      importance: Importance.defaultImportance);

  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print("Title: ${message.notification?.title}");
    print("Body: ${message.notification?.body}");
    print("Payload: ${message.data}");
  }

  static void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }
    navigatorKey.currentState?.pushNamed(MainPage.routeName, arguments: 0);
  }

  static Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      Constants().getToast("new notification");
      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                _androidChannel.id,
                _androidChannel.name,
                channelDescription: _androidChannel.description,
                icon: "@mipmap/ic_launcher",
                priority: Priority.max,
                importance: Importance.max
              )),
          payload: jsonEncode(message.toMap()));
    });
  }

  static Future initLocalNotification() async {
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
          handleMessage(null);
        });
  }

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("fcm token : $fcmToken");
    initPushNotifications();
    initLocalNotification();
  }
}
