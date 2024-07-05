import 'package:leyana/services/dio_services.dart';
import 'package:leyana/models/verse_db_model.dart';
import 'package:leyana/services/managers/settings_manager.dart';

class VersesManager {
  static Future<VerseDBModel> getTodayRandomVerse() async {
    final versesList = await VersesManager.getVerses();
    final userUniqueNumber = int.parse(
        await SettingsManager.getSetting(SettingName.userUniqueNumber));

    final randomIndex =
        (DateTime.now().day * userUniqueNumber) % versesList.length;
    final verse = versesList[randomIndex];
    return verse;
  }

  static Future<String> praseVerseCurrentUser(VerseDBModel verseModel) async {
    final bool isMale =
        (await SettingsManager.getSetting(SettingName.isMale)) == "true"
            ? true
            : false;

    // Replace Name Placeholder with Real Name
    final name = await SettingsManager.getSetting(SettingName.name);

    return praseVerse(verseModel.verse, isMale, name);
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

    return finalVerse;
  }

  static Future<List<VerseDBModel>> getVerses() async {
    final List versesList = (await (await DioService.getInstance())
            .get('https://leyaana.pages.dev/verses.json'))
        .data;
    return versesList
        .map((verse) => VerseDBModel()
          ..verse = verse["verse"]
          ..realId = verse["_id"])
        .toList();
  }
}
