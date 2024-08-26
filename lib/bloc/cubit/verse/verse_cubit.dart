import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leyana/models/verse_db_model.dart';
import 'package:leyana/services/managers/verses_manager.dart';
import 'package:meta/meta.dart';

part 'verse_state.dart';

class VerseCubit extends Cubit<VerseState> {
  VerseCubit() : super(VerseInitial());

  Future<void> loadVerse() async {
    try {
      emit(VerseLoading());
      // Simulate a delay for loading data
      await Future.delayed(const Duration(seconds: 2));

      // Fetch verses from your database or API
      VerseDBModel randomVerse = await fetchVerseOnlineOrOffline();

      emit(VerseLoaded(randomVerse));
    } catch (e) {
      emit(VerseError(e.toString()));
    }
  }
}

Future<VerseDBModel> fetchVerseOnlineOrOffline() async {
  return await VersesManager.getTodayRandomVerse();
}
