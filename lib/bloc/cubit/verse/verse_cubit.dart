import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leyana/models/verse_db_model.dart';
import 'package:leyana/services/managers/verses_manager.dart';

part 'verse_state.dart';

class VerseCubit extends Cubit<VerseState> {
  VerseCubit() : super(VerseInitial());

  Future<void> loadVerse() async {
    try {
      emit(VerseLoading());
      await Future.delayed(const Duration(seconds: 2));

      final randomVerse = await VersesManager.getTodayRandomVerse();

      randomVerse.fold(
        (verse) => emit(VerseLoaded(verse)),
        (error) => emit(VerseError(error.message)),
      );
    } catch (e) {
      emit(VerseError("حدث خطأ ما برجاء المحاولة مرة أخرى"));
    }
  }
}
