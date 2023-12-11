import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';
import '../pages/main_page.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();


  // ignore: close_sinks
  static final onNotifications = BehaviorSubject<String>();

  static Future _notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
      'channel id',
      'channel name',
      importance: Importance.max,
    ));
  }

  static void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }
    navigatorKey.currentState?.pushNamed(MainPage.routeName, arguments: 0);
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings("@mipmap/ic_launcher");
    final ios =DarwinInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: ios);


    await _notification.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
          handleMessage(null);
        });

    if (initScheduled) {
      tz.initializeTimeZones();
      // final locationName = await FlutterNativeTimezone.getLocalTimezone();
      // tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static void showNotification(
      {int id = 0,
      required String title,
      required String body,
      required String payload}) async {
    _notification.show(id, title, body, await _notificationDetails(),
        payload: payload);
  }

  static void showScheduledNotification(
      {int id = 0,
      required String title,
      required String body,
      required String payload,
      required Time time,
      required List<int> days}) async {
    print(time.hour.toString() + " : hour time");
    print(days.toString() + " : minute time");

    _notification.zonedSchedule(
      id,
      title,
      body,
      _scheduleWeekly(time, days: days),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    print("remind me every day");
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days: 1))
        : scheduledDate;
  }

  static tz.TZDateTime _scheduleWeekly(Time time, {required List<int> days}) {
    tz.TZDateTime scheduledDate = _scheduleDaily(time);
    while (!days.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    return scheduledDate;
  }
}
