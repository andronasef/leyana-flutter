part of 'god_name_cubit.dart';

@immutable
sealed class GodNameState {}

final class GodNameInitial extends GodNameState {}

final class GodNameLoading extends GodNameState {}

final class GodNameLoaded extends GodNameState {
  final GodNameDBModel godName;

  GodNameLoaded(this.godName);
}

final class GodNameError extends GodNameState {
  final String message;

  GodNameError(this.message);
}
