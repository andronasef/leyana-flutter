import 'package:flutter/material.dart';
import 'package:leyana/types/schedule_notification_props.dart';

const kAppPackageName = "";

class Config {
  static const kIsDevicePreview = false;
  static const kTestingSharingAppPopup = true;
  static const kTestingBlessingsIndicator = true; // للاختبار: يظهر الindicator دايماً
}

class AppUrls {
  static const String contact = "mailto:andronasef@gmail.com";
  static const String rate = "market://details?id=com.increase.leyana";
  static const String shareGooglePlay =
      "https://play.google.com/store/apps/details?id=com.increase.leyana";
  static const String share =
      "حبيت اشارك معاك ابليكشن ليا انا.\nفكره الابليكيشن ببساطة انه بيشاركك معاك ايات الكتاب المقدس بصورة مختلفه انه بيخليها ليه انت مكتوبه باسمك انت / انتي\nوده لينك الابليكشن:$shareGooglePlay";
  static const String support = "https://forms.gle/TkzqvUNQ26TNU33F6";
  static const String privacy =
      "https://increasinglabs.github.io/apps-privacy-policy/leyana";

  static get kAppShortname => kAppPackageName;
}

class LocalNotifysList {
  static final DAILY_NOTIFICATION = ScheduleNotificationProps(
    id: 0,
    title: "ليك انت",
    body: "ادخل اقرا ايه النهارده واتشجع 💖",
    scheduledDate: DateTime(0, 0, 0, 9, 0, 0),
  );
  static ScheduleNotificationProps customDailyNotification(TimeOfDay time) =>
      ScheduleNotificationProps(
        id: 0,
        title: "ليك انت",
        body: "ادخل اقرا ايه النهارده واتشجع 💖",
        scheduledDate: DateTime(0, 0, 0, time.hour, time.minute, 0),
      );
}
