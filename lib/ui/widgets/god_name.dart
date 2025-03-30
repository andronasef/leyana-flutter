import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leyana/models/god_name_db_model.dart';
import 'package:leyana/services/managers/favorite_god_names_manager.dart';
import 'package:leyana/utils/snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class GodName extends StatelessWidget {
  const GodName({
    super.key,
    required this.godNameModel,
    this.isFavoriteList = false,
  });

  final GodNameDBModel godNameModel;
  final bool isFavoriteList;

  void _onShare() {
    Share.share(
        "${godNameModel.name}\n${godNameModel.meaning}\n\n${godNameModel.content}");
  }

  void _onCopy(BuildContext context) {
    Clipboard.setData(ClipboardData(
      text:
          "${godNameModel.name}\n${godNameModel.meaning}\n\n${godNameModel.content}",
    ));
    showSnackbar(context, "تم نسخ النص");
  }

  void _showDeleteConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الاسم'),
        content: const Text('هل تريد حذف الاسم من قائمة المفضلة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('الغاء'),
          ),
          TextButton(
            onPressed: () {
              FavoriteGodNamesManager.deleteFavorite(godNameModel);
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
            godNameModel.name.split("-")[0],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            godNameModel.meaning,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 16),
          // Text Button to show the content
          FilledButton(
            onPressed: () => context.push('/god-name/${godNameModel.realId}'),
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
                    FavoriteGodNamesManager.toggleFavorite(godNameModel);
                  }
                },
                icon: isFavoriteList
                    ? const Icon(Icons.bookmark_remove)
                    : StreamBuilder(
                        stream: FavoriteGodNamesManager.listenIsFavorite(
                            godNameModel),
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
