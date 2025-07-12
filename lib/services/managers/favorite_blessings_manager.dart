import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:leyana/models/blessing_db_model.dart';
import 'package:leyana/services/database_service.dart';
import 'package:leyana/services/share_popup_service.dart';

class FavoriteBlessingsManager {
  static Stream<List<BlessingDBModel>> listenToFavorites() async* {
    if (!(await DatabaseService.getInstance()).isOpen) return;
    yield* (await DatabaseService.getInstance())
        .blessingDBModels
        .where()
        .watch(fireImmediately: true);
  }

  static void toggleFavorite(BlessingDBModel model,
      [BuildContext? context]) async {
    if (!(await DatabaseService.getInstance()).isOpen) return;

    if (await (await DatabaseService.getInstance())
            .blessingDBModels
            .where()
            .filter()
            .realIdEqualTo(model.realId)
            .findFirst() !=
        null) {
      deleteFavorite(model);
    } else {
      addFavorite(model);
      // Show popup when adding to favorites
      if (context != null && context.mounted) {
        SharePopupService.onFavoriteAdded(context);
      }
    }
  }

  static Stream<List<BlessingDBModel>> listenIsFavorite(
      BlessingDBModel model) async* {
    if (!(await DatabaseService.getInstance()).isOpen) return;
    yield* (await DatabaseService.getInstance())
        .blessingDBModels
        .where()
        .filter()
        .isarIdEqualTo(model.isarId)
        .watch(fireImmediately: true);
  }

  static addFavorite(BlessingDBModel model) async {
    if (!(await DatabaseService.getInstance()).isOpen) return;

    await (await DatabaseService.getInstance()).writeTxn(() async {
      await (await DatabaseService.getInstance()).blessingDBModels.put(model);
    });
  }

  static void deleteFavorite(BlessingDBModel model) async {
    if (!(await DatabaseService.getInstance()).isOpen) return;

    await (await DatabaseService.getInstance()).writeTxn(() async {
      await (await DatabaseService.getInstance())
          .blessingDBModels
          .delete(model.isarId);
    });
  }
}
