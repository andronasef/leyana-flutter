import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leyana/models/blessing_db_model.dart';
import 'package:leyana/services/managers/favorite_blessings_manager.dart';
import 'package:leyana/utils/snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class Blessing extends StatelessWidget {
  const Blessing({
    super.key,
    required this.blessingModel,
    this.isFavoriteList = false,
  });

  final BlessingDBModel blessingModel;
  final bool isFavoriteList;

  void _onShare() {
    Share.share(
        "${blessingModel.name}\n${blessingModel.meaning}\n\n${blessingModel.content}");
  }

  void _onCopy(BuildContext context) {
    Clipboard.setData(ClipboardData(
      text:
          "${blessingModel.name}\n${blessingModel.meaning}\n\n${blessingModel.content}",
    ));
    showSnackbar(context, "تم نسخ النص");
  }

  void _showDeleteConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف البركة'),
        content: const Text('هل تريد حذف البركة من قائمة المفضلة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('الغاء'),
          ),
          TextButton(
            onPressed: () {
              FavoriteBlessingsManager.deleteFavorite(blessingModel);
              Navigator.of(context).pop();
            },
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            blessingModel.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            blessingModel.meaning,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 16),
          // Text Button to show the content
          if (blessingModel.content.isNotEmpty)
            FilledButton(
              onPressed: () =>
                  context.push('/blessing/${blessingModel.realId}'),
              child: const Text('اعرض المزيد'),
            ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _onShare,
                icon: const Icon(Icons.share),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  if (isFavoriteList) {
                    _showDeleteConfirm(context);
                  } else {
                    FavoriteBlessingsManager.toggleFavorite(blessingModel);
                  }
                },
                icon: isFavoriteList
                    ? const Icon(Icons.bookmark_remove)
                    : StreamBuilder(
                        stream: FavoriteBlessingsManager.listenIsFavorite(
                            blessingModel),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Icon(Icons.bookmark_add);
                          }

                          final isFavorite = snapshot.data!.isNotEmpty;
                          return Icon(isFavorite
                              ? Icons.bookmark_remove
                              : Icons.bookmark_add);
                        },
                      ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _onCopy(context),
                icon: const Icon(Icons.copy),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
