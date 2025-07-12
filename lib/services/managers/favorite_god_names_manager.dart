import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:leyana/models/god_name_db_model.dart';
import 'package:leyana/services/database_service.dart';
import 'package:leyana/services/share_popup_service.dart';

class FavoriteGodNamesManager {
  static Stream<List<GodNameDBModel>> listenToFavorites() async* {
    if (!(await DatabaseService.getInstance()).isOpen) return;
    yield* (await DatabaseService.getInstance())
        .godNameDBModels
        .where()
        .watch(fireImmediately: true);
  }

  static void toggleFavorite(GodNameDBModel model,
      [BuildContext? context]) async {
    if (!(await DatabaseService.getInstance()).isOpen) return;

    if (await (await DatabaseService.getInstance())
            .godNameDBModels
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

  static Stream<List<GodNameDBModel>> listenIsFavorite(
      GodNameDBModel model) async* {
    if (!(await DatabaseService.getInstance()).isOpen) return;
    yield* (await DatabaseService.getInstance())
        .godNameDBModels
        .where()
        .filter()
        .isarIdEqualTo(model.isarId)
        .watch(fireImmediately: true);
  }

  static addFavorite(GodNameDBModel model) async {
    if (!(await DatabaseService.getInstance()).isOpen) return;

    await (await DatabaseService.getInstance()).writeTxn(() async {
      await (await DatabaseService.getInstance()).godNameDBModels.put(model);
    });
  }

  static void deleteFavorite(GodNameDBModel model) async {
    if (!(await DatabaseService.getInstance()).isOpen) return;

    await (await DatabaseService.getInstance()).writeTxn(() async {
      await (await DatabaseService.getInstance())
          .godNameDBModels
          .delete(model.isarId);
    });
  }
}
