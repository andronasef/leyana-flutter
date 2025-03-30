import 'dart:math';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:leyana/core/errors/failure.dart';
import 'package:leyana/services/dio_services.dart';
import 'package:leyana/models/verse_db_model.dart';
import 'package:leyana/services/managers/settings_manager.dart';

class VersesManager {
  static Future<Either<VerseDBModel, Failure>> getTodayRandomVerse() async {
    final versesList = await VersesManager.getVerses();

    if (versesList.isEmpty) {
      return right(Failure(
          "لم يتم العثور على الآيات بسبب الانترتت برجاء اغلاق الابليكيشن والتاكد من وجود الانترنت"));
    }

    final randomIndex = Random().nextInt(versesList.length);

    final verse = versesList[randomIndex];

    // final praseVerseCurrentUser =
    //     await VersesManager.praseVerseCurrentUser(verse);

    // Verse As it is
    return left(verse);
  }

  static Future<VerseDBModel?> praseVerseCurrentUser(
      VerseDBModel verseModel) async {
    final bool isMale =
        (await SettingsManager.getSetting(SettingName.isMale)) == "true"
            ? true
            : false;

    // Replace Name Placeholder with Real Name
    String? name = await SettingsManager.getSetting(SettingName.name);

    if (name == null) return null;

    verseModel.verse = await praseVerse(verseModel.verse, isMale, name);

    return verseModel;
  }

  static Future<String> praseVerse(
      String verse, bool isMale, String name) async {
    late String finalVerse;

    // Get Verse by Gender
    final bioVerse = verse.split("---");

    if (bioVerse.length == 2) {
      finalVerse = isMale ? bioVerse[0] : bioVerse[1];
    } else {
      // If Verse is Unisex
      finalVerse = verse;
    }

    // Replace Name Placeholder with Real Name
    finalVerse = finalVerse.replaceAll("<الاسم>", name);

    return finalVerse.trim();
  }

  static Future<List<VerseDBModel>> getVerses() async {
    try {
      final Response verseRes = (await (await DioService.getInstance())
          .get('https://leyaana.pages.dev/verses.json'));

      final List versesList = verseRes.data;
      return versesList
          .map((verse) => VerseDBModel()
            ..verse = verse["verse"]
            ..realId = verse["_id"])
          .toList();
    } on Exception catch (e) {
      dev.log(e.toString());
      return [];
    }
  }
}
