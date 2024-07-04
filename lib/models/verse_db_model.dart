import 'package:isar/isar.dart';
import 'package:leyana/utils/fast_hash.dart';

part 'verse_db_model.g.dart';

@collection
class VerseDBModel {
  Id get isarId => fastHash(realId);
  late String realId;
  late String verse;
  DateTime createdAt = DateTime.now();
}
