import 'package:isar/isar.dart';
import 'package:leyana/utils/fast_hash.dart';

part 'blessing_db_model.g.dart';

@collection
class BlessingDBModel {
  Id get isarId => fastHash(realId);

  @Index()
  late String realId;
  late String name;
  late String meaning;
  late String content;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlessingDBModel &&
          runtimeType == other.runtimeType &&
          realId == other.realId;

  @override
  int get hashCode => realId.hashCode;
}
