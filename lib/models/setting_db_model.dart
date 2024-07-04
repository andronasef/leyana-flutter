import 'package:isar/isar.dart';
import 'package:leyana/utils/fast_hash.dart';

part 'setting_db_model.g.dart';

@collection
class SettingDBModel {
  late String name;
  Id get isarId => fastHash(name);
  String? value;
}
