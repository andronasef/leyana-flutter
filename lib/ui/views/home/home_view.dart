import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leyana/bloc/cubit/god_name/god_name_cubit.dart';
import 'package:leyana/bloc/cubit/verse/verse_cubit.dart';
import 'package:leyana/types/content_type.dart';
import 'package:leyana/ui/widgets/verse.dart';
import 'package:leyana/ui/widgets/god_name.dart';
import 'package:leyana/utils/snackbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ContentType _selectedType = ContentType.verse;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Expanded(
            child: _selectedType == ContentType.verse
                ? BlocConsumer<VerseCubit, VerseState>(
                    builder: (context, state) {
                      if (state is VerseLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is VerseLoaded) {
                        return Verse(
                          verseModel: state.randomVerse,
                          isFavoriteList: false,
                        );
                      }
                      return const Center(child: Text('حدث خطأ ما'));
                    },
                    listener: (context, state) {
                      if (state is VerseError) {
                        showSnackbar(context, state.message);
                      }
                    },
                  )
                : _selectedType == ContentType.godName
                    ? BlocConsumer<GodNameCubit, GodNameState>(
                        builder: (context, state) {
                          if (state is GodNameLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is GodNameLoaded) {
                            return GodName(
                              godNameModel: state.godName,
                            );
                          }
                          return const Center(child: Text('حدث خطأ ما'));
                        },
                        listener: (context, state) {
                          if (state is GodNameError) {
                            showSnackbar(context, state.message);
                          }
                        },
                      )
                    : const Center(child: Text('قريباً')),
          ),
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
}
