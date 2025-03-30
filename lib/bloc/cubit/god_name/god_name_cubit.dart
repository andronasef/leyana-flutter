import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leyana/models/god_name_db_model.dart';
import 'package:leyana/services/managers/god_names_manager.dart';

part 'god_name_state.dart';

class GodNameCubit extends Cubit<GodNameState> {
  GodNameCubit() : super(GodNameInitial());

  Future<void> loadRandomName() async {
    try {
      emit(GodNameLoading());
      await Future.delayed(const Duration(seconds: 2));

      final randomGodName = await GodNamesManager.getRandomGodName();

      randomGodName.fold(
        (godName) => emit(GodNameLoaded(godName)),
        (error) => emit(GodNameError(error.message)),
      );
    } catch (e) {
      log(e.toString());
      emit(GodNameError("حدث خطأ ما برجاء المحاولة مرة أخرى"));
    }
  }
}
