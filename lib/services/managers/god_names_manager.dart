import 'dart:math';
import 'package:fpdart/fpdart.dart';
import 'package:leyana/core/errors/failure.dart';
import 'package:leyana/models/god_name_db_model.dart';
import 'package:leyana/services/dio_services.dart';

class GodNamesManager {
  static Future<GodNameDBModel?> getGodName(String realId) async {
    final names = await getGodNames();
    try {
      return names.firstWhere((name) => name.realId == realId);
    } catch (e) {
      return null;
    }
  }

  static Future<Either<GodNameDBModel, Failure>> getRandomGodName() async {
    final names = await getGodNames();
    if (names.isEmpty) {
      return right(Failure(
          "لم يتم العثور على الأسماء بسبب الانترتت برجاء اغلاق الابليكيشن والتاكد من وجود الانترنت"));
    }
    return left(names[Random().nextInt(names.length)]);
  }

  static Future<List<GodNameDBModel>> getGodNames() async {
    try {
      final response = await (await DioService.getInstance())
          .get('https://leyaana.pages.dev/godNames.json');

      return (response.data as List)
          .map((name) => GodNameDBModel()
            ..realId = name['id']
            ..name = name['name']
            ..meaning = name['mean']
            ..content = name['content'])
          .toList();
    } catch (e) {
      return [];
    }
  }
}
