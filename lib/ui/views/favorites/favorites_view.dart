import 'package:flutter/material.dart';
import 'package:leyana/models/god_name_db_model.dart';
import 'package:leyana/models/verse_db_model.dart';
import 'package:leyana/services/managers/favorite_god_names_manager.dart';
import 'package:leyana/services/managers/favorite_verses_manager.dart';
import 'package:animations/animations.dart';
import 'package:leyana/types/content_type.dart';
import 'package:leyana/ui/widgets/god_name.dart';
import 'package:leyana/ui/widgets/verse.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  ContentType _selectedType = ContentType.verse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        children: [
          Expanded(
            child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (
                Widget child,
                Animation<double> primaryAnimation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: Container(
                key: ValueKey(_selectedType), // Add key here
                child: _buildContentList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ContentType.values.map((type) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    selected: _selectedType == type,
                    label: Text(type.label),
                    onSelected: (selected) {
                      setState(() {
                        _selectedType = type;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildContentList() {
    return [
      if (_selectedType == ContentType.verse) _buildVerseList(),
      if (_selectedType == ContentType.godName) _buildGodNamesList(),
      if (_selectedType == ContentType.blessing)
        const Center(child: Text('بركات روحية قريبا')),
    ].first;
  }

  Widget _buildVerseList() {
    return StreamBuilder<List<VerseDBModel>>(
      stream: FavoriteVersesManager.listenToVerses(),
      builder: (context, verses) {
        if (verses.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (verses.data == null || verses.data!.isEmpty) {
          return const Center(child: Text('لا توجد آيات مفضلة'));
        }

        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: verses.data!.length,
          itemBuilder: (context, index) {
            return _buildFavoriteCard(
              content: Verse(
                isFavoriteList: true,
                verseModel: verses.data![index],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGodNamesList() {
    return StreamBuilder<List<GodNameDBModel>>(
      stream: FavoriteGodNamesManager.listenToFavorites(),
      builder: (context, names) {
        if (names.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (names.data == null || names.data!.isEmpty) {
          return const Center(child: Text('لا توجد أسماء مفضلة'));
        }

        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: names.data!.length,
          itemBuilder: (context, index) {
            return _buildFavoriteCard(
              content: GodName(
                isFavoriteList: true,
                godNameModel: names.data![index],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFavoriteCard({required Widget content}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      clipBehavior: Clip.hardEdge,
      child: content,
    );
  }
}
