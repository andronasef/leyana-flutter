import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
import 'package:leyana/models/setting_db_model.dart';
import 'package:leyana/services/database_service.dart';
import 'package:leyana/utils/logger.dart';

class SettingsManager {
  static Future<void> setSetting<T>(SettingName name, String value) async {
    try {
      logger.i('Trying to Setting $name to $value');
      if (!(await DatabaseService.getInstance()).isOpen) return;

      final setting = SettingDBModel()
        ..name = name.toString()
        ..value = value;

      await (await DatabaseService.getInstance()).writeTxn(() async {
        await (await DatabaseService.getInstance())
            .settingDBModels
            .put(setting);
      });
      logger.i('Successfully Setting $name to $value done');
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  static Future<String?> getSetting(SettingName name) async {
    try {
      logger.i('Trying to get Setting $name');
      if (!(await DatabaseService.getInstance()).isOpen) return '';

      final setting = await (await DatabaseService.getInstance())
          .settingDBModels
          .where()
          .filter()
          .nameEqualTo(name.toString())
          .findFirst();

      return setting?.value;
    } on Exception catch (e) {
      logger.e(e);
    }
    return null;
  }

  static Stream<List<SettingDBModel>> listenToSetting(SettingName name) async* {
    try {
      logger.i('Trying to listen to Setting $name');
      yield* (await DatabaseService.getInstance())
          .settingDBModels
          .where()
          .filter()
          .nameEqualTo(name.toString())
          .watch(fireImmediately: true);
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  static Future<void> initializeDefaultSettings() async {
    // Initialize name if not set
    final String? name = await getSetting(SettingName.name);
    if (name == null) {
      await setSetting(SettingName.name, "");
    }

    // Initialize gender if not set (default to male)
    final String? isMale = await getSetting(SettingName.isMale);
    if (isMale == null) {
      await setSetting(SettingName.isMale, "true");
    }

    // Initialize dark mode if not set
    await _initializeDarkMode();

    // Initialize share popup setting if not set
    final String? hasSeenSharePopup =
        await getSetting(SettingName.hasSeenSharePopup);
    if (hasSeenSharePopup == null) {
      await setSetting(SettingName.hasSeenSharePopup, "false");
    }

    // Initialize last postpone date if not set
    final String? lastPostpone =
        await getSetting(SettingName.lastSharePopupPostpone);
    if (lastPostpone == null) {
      await setSetting(SettingName.lastSharePopupPostpone, "0");
    }

    // Initialize has shared app setting if not set
    final String? hasSharedApp = await getSetting(SettingName.hasSharedApp);
    if (hasSharedApp == null) {
      await setSetting(SettingName.hasSharedApp, "false");
    }
  }

  static Future<void> _initializeDarkMode() async {
    final String? isDarkModeInDB =
        await SettingsManager.getSetting(SettingName.isDarkMode);

    if (isDarkModeInDB == null) {
      final systemBrightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final bool isSystemDarkMode = systemBrightness == Brightness.dark;

      await SettingsManager.setSetting(
          SettingName.isDarkMode, isSystemDarkMode.toString());
    }
  }

  static Future<SettingDBModel> getIsDarkModelInitial() async {
    await initializeDefaultSettings();

    final bool isDarkMode =
        await SettingsManager.getSetting(SettingName.isDarkMode) == "true";

    return SettingDBModel()
      ..name = SettingName.isDarkMode.toString()
      ..value = isDarkMode.toString();
  }
}

enum SettingName {
  isIntroDone,
  name,
  isMale,
  isDarkMode,
  notificationTime,
  hasSeenSharePopup,
  lastSharePopupPostpone,
  hasSharedApp
}
