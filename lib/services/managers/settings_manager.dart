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

  static Future<SettingDBModel> getIsDarkModelInitial() async {
    final String? isDarkModeInDB =
        await SettingsManager.getSetting(SettingName.isDarkMode);

    if (isDarkModeInDB == null) {
      final systemBrightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final bool isSystemDarkMode = systemBrightness == Brightness.dark;

      SettingsManager.setSetting(
          SettingName.isDarkMode, isSystemDarkMode.toString());
    }
    final bool isDarkMode =
        await SettingsManager.getSetting(SettingName.isDarkMode) == "true";

    final SettingDBModel isDarkModelInitial = SettingDBModel()
      ..name = SettingName.isDarkMode.toString()
      ..value = isDarkMode.toString();

    return isDarkModelInitial;
  }
}

enum SettingName {
  isIntroDone,
  name,
  isMale,
  userUniqueNumber,
  isDarkMode,
  notificationTime
}
