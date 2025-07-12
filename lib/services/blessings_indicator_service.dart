import 'package:flutter/foundation.dart';
import 'package:leyana/core/values.dart';
import 'package:leyana/services/managers/settings_manager.dart';

class BlessingsIndicatorService {
  static const int _indicatorDays = 10; // عدد الأيام اللي يظهر فيها الindicator

  /// تحقق من إن الindicator يتم عرضه أم لا
  static Future<bool> shouldShowIndicator() async {
    // في وضع الاختبار، يظهر الindicator دايماً
    if (Config.kTestingBlessingsIndicator && kDebugMode) {
      return true;
    }

    final String? firstSeenDateStr = 
        await SettingsManager.getSetting(SettingName.blessingsFirstSeenDate);

    // لو ميشوفهاش قبل كده، يبقى يعرض الindicator
    if (firstSeenDateStr == null || firstSeenDateStr == "0") {
      return true;
    }

    final int firstSeenTimestamp = int.tryParse(firstSeenDateStr) ?? 0;
    if (firstSeenTimestamp == 0) {
      return true;
    }

    final DateTime firstSeenDate = 
        DateTime.fromMillisecondsSinceEpoch(firstSeenTimestamp);
    final DateTime now = DateTime.now();
    final int daysDifference = now.difference(firstSeenDate).inDays;

    // يعرض الindicator لحد 10 أيام
    return daysDifference < _indicatorDays;
  }

  /// تسجيل أول مرة شوف البركات الروحية
  static Future<void> markBlessingsAsSeen() async {
    final String? firstSeenDateStr = 
        await SettingsManager.getSetting(SettingName.blessingsFirstSeenDate);

    // لو ميشوفهاش قبل كده، يسجل التاريخ الحالي
    if (firstSeenDateStr == null || firstSeenDateStr == "0") {
      final String currentTimestamp = 
          DateTime.now().millisecondsSinceEpoch.toString();
      await SettingsManager.setSetting(
          SettingName.blessingsFirstSeenDate, currentTimestamp);
    }
  }

  /// حساب عدد الأيام المتبقية لإخفاء الindicator
  static Future<int> getDaysRemaining() async {
    final String? firstSeenDateStr = 
        await SettingsManager.getSetting(SettingName.blessingsFirstSeenDate);

    if (firstSeenDateStr == null || firstSeenDateStr == "0") {
      return _indicatorDays;
    }

    final int firstSeenTimestamp = int.tryParse(firstSeenDateStr) ?? 0;
    if (firstSeenTimestamp == 0) {
      return _indicatorDays;
    }

    final DateTime firstSeenDate = 
        DateTime.fromMillisecondsSinceEpoch(firstSeenTimestamp);
    final DateTime now = DateTime.now();
    final int daysPassed = now.difference(firstSeenDate).inDays;

    return (_indicatorDays - daysPassed).clamp(0, _indicatorDays);
  }

  /// إعادة تعيين الindicator (مفيد للاختبار)
  static Future<void> resetIndicator() async {
    await SettingsManager.setSetting(SettingName.blessingsFirstSeenDate, "0");
  }
}
