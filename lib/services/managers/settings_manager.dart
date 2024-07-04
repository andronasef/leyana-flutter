import 'package:isar/isar.dart';
import 'package:leyana/models/setting_db_model.dart';
import 'package:leyana/services/database_service.dart';

class SettingsManager {
  static Future<void> setSetting<T>(SettingName name, String value) async {
    if (!(await DatabaseService.getInstance()).isOpen) return;

    final setting = SettingDBModel()
      ..name = name.toString()
      ..value = value;

    await (await DatabaseService.getInstance()).writeTxn(() async {
      await (await DatabaseService.getInstance()).settingDBModels.put(setting);
    });
  }

  static Future<String> getSetting(SettingName name) async {
    if (!(await DatabaseService.getInstance()).isOpen) return '';

    final setting = await (await DatabaseService.getInstance())
        .settingDBModels
        .where()
        .filter()
        .nameEqualTo(name.toString())
        .findFirst();

    return setting?.value ?? '';
  }

  static Stream<List<SettingDBModel>> listenToSetting(SettingName name) async* {
    yield* (await DatabaseService.getInstance())
        .settingDBModels
        .where()
        .filter()
        .nameEqualTo(name.toString())
        .watch(fireImmediately: true);
  }
}

enum SettingName { isIntroDone, name, isMale, userUniqueNumber, isDarkMode }
