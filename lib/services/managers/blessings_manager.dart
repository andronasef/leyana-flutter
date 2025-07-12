import 'dart:math';
import 'package:fpdart/fpdart.dart';
import 'package:leyana/core/errors/failure.dart';
import 'package:leyana/models/blessing_db_model.dart';
import 'package:leyana/services/dio_services.dart';

class BlessingsManager {
  static Future<BlessingDBModel?> getBlessing(String realId) async {
    final blessings = await getBlessings();
    try {
      return blessings.firstWhere((blessing) => blessing.realId == realId);
    } catch (e) {
      return null;
    }
  }

  static Future<Either<BlessingDBModel, Failure>> getRandomBlessing() async {
    final blessings = await getBlessings();
    if (blessings.isEmpty) {
      return right(Failure(
          "لم يتم العثور على البركات بسبب الانترنت برجاء اغلاق التطبيق والتأكد من وجود الانترنت"));
    }
    return left(blessings[Random().nextInt(blessings.length)]);
  }

  static Future<List<BlessingDBModel>> getBlessings() async {
    try {
      final response = await (await DioService.getInstance())
          .get('http://leyaana.pages.dev/heavenlyBlessings.json');

      return (response.data as List)
          .map((blessing) => BlessingDBModel()
            ..realId = blessing['id']
            ..name = blessing['name']
            ..meaning = blessing['mean']
            ..content = blessing['content'] ?? '')
          .toList();
    } catch (e) {
      return [];
    }
  }
}
