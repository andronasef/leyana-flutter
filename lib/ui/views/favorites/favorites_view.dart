import 'package:flutter/material.dart';
import 'package:leyana/services/managers/favorite_verses_manager.dart';
import 'package:leyana/ui/widgets/verse.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // widget repeater
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        children: [
          // SearchBar(
          //   leading: const Icon(Icons.search),
          //   controller: _searchController,
          //   hintText: "جزء من الايه",
          // ),
          const SizedBox(height: 24),
          Expanded(
            child: StreamBuilder(
              stream: FavoriteVersesManager.listenToVerses(),
              builder: (context, verses) {
                if (verses.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (verses.data == null) {
                  return const Center(child: Text('حدث خطأ ما'));
                }
                if (verses.data!.isEmpty) {
                  return const Center(child: Text('لا توجد ايات مفضلة'));
                }

                final int versesLength = verses.data!.length - 1;

                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: verses.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: versesLength - 1 == index ? 24 : 0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.25),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ]),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 24),
                          clipBehavior: Clip.hardEdge,
                          child: Verse(
                              isFavoriteList: true,
                              verseModel: verses.data![index])),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
