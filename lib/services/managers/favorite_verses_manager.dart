import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:leyana/models/verse_db_model.dart';
import 'package:leyana/services/database_service.dart';
import 'package:leyana/services/share_popup_service.dart';

class FavoriteVersesManager {
  static Stream<List<VerseDBModel>> listenToVerses() async* {
    if (!(await DatabaseService.getInstance()).isOpen) return;
    yield* (await DatabaseService.getInstance())
        .verseDBModels
        .where()
        .watch(fireImmediately: true);
  }

  static void toggleVerse(VerseDBModel verseDBModel,
      [BuildContext? context]) async {
    if (!(await DatabaseService.getInstance()).isOpen) return;

    if (await (await DatabaseService.getInstance())
            .verseDBModels
            .where()
            .filter()
            .realIdEqualTo(verseDBModel.realId)
            .findFirst() !=
        null) {
      deleteFavoriteVerse(verseDBModel);
    } else {
      addFavoriteVerse(verseDBModel);
      // Show popup when adding to favorites
      if (context != null && context.mounted) {
        SharePopupService.onFavoriteAdded(context);
      }
    }
  }

  static Stream<List<VerseDBModel>> listenIsFavoriteVerse(
      VerseDBModel verseDBModel) async* {
    if (!(await DatabaseService.getInstance()).isOpen) return;
    yield* (await DatabaseService.getInstance())
        .verseDBModels
        .where()
        .filter()
        .isarIdEqualTo(verseDBModel.isarId)
        .watch(fireImmediately: true);
  }

  static addFavoriteVerse(VerseDBModel verseDBModel) async {
    if (!(await DatabaseService.getInstance()).isOpen) return;

    await (await DatabaseService.getInstance()).writeTxn(() async {
      await (await DatabaseService.getInstance())
          .verseDBModels
          .put(verseDBModel);
    });
  }

  static void deleteFavoriteVerse(VerseDBModel verseDBModel) async {
    if (!(await DatabaseService.getInstance()).isOpen) return;

    await (await DatabaseService.getInstance()).writeTxn(() async {
      await (await DatabaseService.getInstance())
          .verseDBModels
          .delete(verseDBModel.isarId);
    });
  }
}
