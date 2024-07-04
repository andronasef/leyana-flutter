import 'package:flutter/material.dart';
import 'package:leyana/services/managers/verses_manager.dart';
import 'package:leyana/ui/widgets/verse.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: FutureBuilder(
        future: VersesManager.getTodayRandomVerse(),
        builder: (context, verse) {
          if (verse.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (verse.data == null) {
            return const Center(child: Text('حدث خطأ ما'));
          }

          return Verse(
            verseModel: verse.data!,
            isFavoriteList: false,
          );
        },
      ),
    );
  }
}
