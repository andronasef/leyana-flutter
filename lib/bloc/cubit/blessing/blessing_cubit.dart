import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leyana/models/blessing_db_model.dart';
import 'package:leyana/services/managers/blessings_manager.dart';

part 'blessing_state.dart';

class BlessingCubit extends Cubit<BlessingState> {
  BlessingCubit() : super(BlessingInitial());

  Future<void> loadRandomBlessing() async {
    try {
      emit(BlessingLoading());
      await Future.delayed(const Duration(seconds: 2));

      final randomBlessing = await BlessingsManager.getRandomBlessing();

      randomBlessing.fold(
        (blessing) => emit(BlessingLoaded(blessing)),
        (error) => emit(BlessingError(error.message)),
      );
    } catch (e) {
      log(e.toString());
      emit(BlessingError("حدث خطأ ما برجاء المحاولة مرة أخرى"));
    }
  }
}
