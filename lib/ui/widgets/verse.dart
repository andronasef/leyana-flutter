import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leyana/models/verse_db_model.dart';
import 'package:leyana/services/managers/favorite_verses_manager.dart';
import 'package:leyana/services/managers/verses_manager.dart';
import 'package:leyana/utils/snackbar.dart';
import 'package:share_plus/share_plus.dart';

class Verse extends StatefulWidget {
  const Verse({
    super.key,
    required this.verseModel,
    required this.isFavoriteList,
  });

  final VerseDBModel verseModel;
  final bool isFavoriteList;

  @override
  State<Verse> createState() => _VerseState();
}

class _VerseState extends State<Verse> {
  String parsedVerseText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final parsedVerseModel =
          (await VersesManager.praseVerseCurrentUser(widget.verseModel));
      if (parsedVerseModel == null) return;
      setState(() {
        parsedVerseText = parsedVerseModel.verse;
      });
    });
  }

  void showVerseDeleteConfirm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الآية'),
        content: const Text('هل تريد حذف الآية من قائمة المفضلة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('الغاء'),
          ),
          TextButton(
            onPressed: () {
              FavoriteVersesManager.deleteFavoriteVerse(widget.verseModel);
              Navigator.of(context).pop();
            },
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  void showCopiedAlertSnackbar() {
    showSnackbar(context, "تم نسخ الآية");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          parsedVerseText,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Share Button
          IconButton(
              onPressed: () {
                if (widget.verseModel.verse.isNotEmpty) {
                  Share.share(widget.verseModel.verse);
                }
              },
              icon: const Icon(Icons.share)),
          const SizedBox(width: 8),
          // Bookmark Button
          IconButton(
              onPressed: () {
                if (widget.isFavoriteList) {
                  showVerseDeleteConfirm();
                } else {
                  FavoriteVersesManager.toggleVerse(widget.verseModel, context);
                }
              },
              icon: widget.isFavoriteList
                  ? const Icon(Icons.bookmark_remove)
                  : StreamBuilder(
                      stream: FavoriteVersesManager.listenIsFavoriteVerse(
                          widget.verseModel),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Icon(Icons.bookmark_add);
                        }

                        final isFavorite = snapshot.data!.isNotEmpty;
                        return isFavorite
                            ? const Icon(Icons.bookmark_remove)
                            : const Icon(Icons.bookmark_add);
                      },
                    )),
          const SizedBox(width: 8),
          // Copy Button
          IconButton(
              onPressed: () {
                if (widget.verseModel.verse.isNotEmpty) {
                  showCopiedAlertSnackbar();
                  Clipboard.setData(
                      ClipboardData(text: widget.verseModel.verse));
                }
              },
              icon: const Icon(Icons.copy))
        ])
      ],
    );
  }
}
