import 'package:flutter/material.dart';

class Verse extends StatelessWidget {
  const Verse({
    super.key,
    required this.verse,
  });

  final String verse;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          verse,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          const SizedBox(width: 8),
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_add)),
          const SizedBox(width: 8),
          IconButton(onPressed: () {}, icon: const Icon(Icons.copy))
        ])
      ],
    );
  }
}
