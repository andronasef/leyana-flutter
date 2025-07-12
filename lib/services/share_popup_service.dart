import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leyana/core/values.dart';
import 'package:leyana/services/managers/settings_manager.dart';
import 'package:leyana/ui/widgets/share_app_popup.dart';

class SharePopupService {
  static int _favoriteCount = 0;
  // These values can be customized in Config if needed
  static const int _showAfterFavorites = 3; // Show popup after 3rd favorite
  static const int _postponeDays = 10; // Postpone for 10 days

  /// Call this method whenever a user adds something to favorites
  static Future<void> onFavoriteAdded(BuildContext context) async {
    // Check if user has already shared the app
    final String? hasSharedApp =
        await SettingsManager.getSetting(SettingName.hasSharedApp);

    if (hasSharedApp == "true") {
      return; // Don't show popup if user has already shared the app
    }

    if (Config.kTestingSharingAppPopup && kDebugMode) {
      // In testing mode, always show the popup
      _showSharePopup(context);
      return;
    }

    // Check if we should show popup based on postpone logic
    final bool shouldShow = await _shouldShowPopup();

    if (!shouldShow) {
      return; // Don't show popup if still in postpone period
    }

    _favoriteCount++;

    // Show popup after specific number of favorites
    if (_favoriteCount >= _showAfterFavorites) {
      if (context.mounted) {
        _showSharePopup(context);
        _favoriteCount = 0; // Reset counter
      }
    }
  }

  /// Shows the share popup with a smooth animation
  static void _showSharePopup(BuildContext context) {
    // Add a small delay to ensure the favorite action is completed
    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false, // User must make a choice
          builder: (context) => const ShareAppPopup(),
        );
      }
    });
  }

  /// Reset the favorite counter (useful for testing or reset scenarios)
  static void resetCounter() {
    _favoriteCount = 0;
  }

  /// Check if user has shared the app
  static Future<bool> hasUserSharedApp() async {
    final String? hasSharedApp =
        await SettingsManager.getSetting(SettingName.hasSharedApp);
    return hasSharedApp == "true";
  }

  /// Get days remaining until next popup show (returns 0 if can show now)
  static Future<int> getDaysUntilNextShow() async {
    final String? lastPostponeStr =
        await SettingsManager.getSetting(SettingName.lastSharePopupPostpone);

    if (lastPostponeStr == null || lastPostponeStr == "0") {
      return 0; // Can show now
    }

    final int lastPostponeTimestamp = int.tryParse(lastPostponeStr) ?? 0;
    final DateTime lastPostponeDate =
        DateTime.fromMillisecondsSinceEpoch(lastPostponeTimestamp);
    final DateTime now = DateTime.now();
    final int daysDifference = now.difference(lastPostponeDate).inDays;

    final int daysRemaining = _postponeDays - daysDifference;
    return daysRemaining > 0 ? daysRemaining : 0;
  }

  /// Force show popup (for testing purposes)
  static void forceShowPopup(BuildContext context) {
    _showSharePopup(context);
  }

  /// Check if popup should be shown based on postpone logic
  static Future<bool> _shouldShowPopup() async {
    final String? lastPostponeStr =
        await SettingsManager.getSetting(SettingName.lastSharePopupPostpone);

    if (lastPostponeStr == null || lastPostponeStr == "0") {
      return true; // Never postponed before, can show
    }

    final int lastPostponeTimestamp = int.tryParse(lastPostponeStr) ?? 0;
    final DateTime lastPostponeDate =
        DateTime.fromMillisecondsSinceEpoch(lastPostponeTimestamp);
    final DateTime now = DateTime.now();
    final int daysDifference = now.difference(lastPostponeDate).inDays;

    return daysDifference >= _postponeDays; // Show if 10+ days have passed
  }

  /// Mark popup as postponed (called when user clicks "لاحقاً")
  static Future<void> postponePopup() async {
    final String currentTimestamp =
        DateTime.now().millisecondsSinceEpoch.toString();
    await SettingsManager.setSetting(
        SettingName.lastSharePopupPostpone, currentTimestamp);
  }

  /// Mark app as shared (called when user actually shares)
  static Future<void> markAppAsShared() async {
    await SettingsManager.setSetting(SettingName.hasSharedApp, "true");
  }
}
