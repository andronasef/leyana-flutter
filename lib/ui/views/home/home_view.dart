import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leyana/bloc/cubit/verse/verse_cubit.dart';
import 'package:leyana/ui/widgets/verse.dart';
import 'package:leyana/utils/snackbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocConsumer<VerseCubit, VerseState>(
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
        ));
  }
}
