import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:leyana/types/schedule_notification_props.dart';
import 'package:leyana/utils/logger.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifyService {
  static FlutterLocalNotificationsPlugin? _localNotify;

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
    logger.i("Successfully Configured local time zone");
  }

  static init() {
    try {
      _configureLocalTimeZone();
      _localNotify = FlutterLocalNotificationsPlugin();
      final android = AndroidInitializationSettings('@mipmap/launcher_icon');
      final initSetting = InitializationSettings(
        android: android,
      );
      _localNotify!.initialize(initSetting);
      logger.i("LocalNotifyService initialized successfully");
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  static Future<FlutterLocalNotificationsPlugin> getInstance() async {
    if (_localNotify == null) {
      await init();
    }
    return _localNotify!;
  }

  static Future<bool> requestNotificationsPermissions() async {
    try {
      final androidPermissons = await (await LocalNotifyService.getInstance())
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final notificationPermissionsAccepted =
          await androidPermissons?.requestNotificationsPermission();
      final exactNotificationPermissionsAccepted =
          await androidPermissons?.requestExactAlarmsPermission();

      final permissionsAccepted = notificationPermissionsAccepted! &&
          exactNotificationPermissionsAccepted!;
      logger.i("Permissions accepted");

      return permissionsAccepted;
    } on Exception catch (e) {
      logger.w("Permissions not accepted");
      logger.e(e);
    }
    return false;
  }

  static Future<void> scheduleNotification(
      {required ScheduleNotificationProps props}) async {
    try {
      if (!await requestNotificationsPermissions()) {
        return;
      }

      final pendingNotificationRequests =
          await (await LocalNotifyService.getInstance())
              .pendingNotificationRequests();

      for (var pendingNotification in pendingNotificationRequests) {
        if (pendingNotification.id == props.id) {
          logger.i(
              "Notification already scheduled. you should update it instead using updateScheduledNotification method.");
          return;
        }
      }

      final android = AndroidNotificationDetails(props.id.toString(), 'LyaAna',
          importance: Importance.high, priority: Priority.high);
      final platform = NotificationDetails(android: android);

      // if in debug mode, schedule notification after 5 seconds
      final scheduledDate = kDebugMode
          ? tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5))
          : tz.TZDateTime.from(props.scheduledDate, tz.local);

      // time between scheduledDate and now
      logger.d(scheduledDate.difference(tz.TZDateTime.now(tz.local)));
      await (await LocalNotifyService.getInstance()).zonedSchedule(
        props.id,
        props.title,
        props.body,
        scheduledDate,
        platform,
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      logger.i("Notification scheduled successfully");
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  static Future<void> cancelNotification(int id) async {
    logger.i("Canceling notification with id: $id");
    await (await LocalNotifyService.getInstance()).cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    logger.i("Canceling all notifications");
    await (await LocalNotifyService.getInstance()).cancelAll();
  }

  static Future<void> updateScheduledNotification(
      ScheduleNotificationProps props) async {
    try {
      logger.i("Updating notification with id: ${props.id}");
      await cancelNotification(props.id);
      await scheduleNotification(props: props);
      logger.i("Notification updated successfully with id: ${props.id}");
    } on Exception catch (e) {
      logger.e(e);
    }
  }
}
