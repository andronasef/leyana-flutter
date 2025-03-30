import 'package:isar/isar.dart';
import 'package:leyana/utils/fast_hash.dart';

part 'god_name_db_model.g.dart';

@collection
class GodNameDBModel {
  Id get isarId => fastHash(realId);

  @Index()
  late String realId;
  late String name;
  late String meaning;
  late String content;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GodNameDBModel &&
          runtimeType == other.runtimeType &&
          realId == other.realId;

  @override
  int get hashCode => realId.hashCode;
}
