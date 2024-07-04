import 'package:isar/isar.dart';
import 'package:leyana/models/setting_db_model.dart';
import 'package:leyana/models/verse_db_model.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static Isar? _instance;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _instance = await Isar.open([VerseDBModelSchema, SettingDBModelSchema],
        directory: dir.path, inspector: true);
  }

  static Future<Isar> getInstance() async {
    if (_instance == null) {
      await init();
    }
    return _instance!;
  }
}
