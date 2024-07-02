import 'package:flutter/material.dart';
import 'package:leyana/ui/widgets/verse.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Verse(
        verse:
            "فقال: إن كنت تسمع لصوت الرب إلهك يا اندرو، وتصنع الحق في عينيه، وتصغى إلى وصاياه وتحفظ جميع فرائضه، فمرضا ما مما وضعته على المصريين لا أضع عليك. فإني أنا الرب شافيك (خر 15: 26)",
      ),
    );
  }
}
