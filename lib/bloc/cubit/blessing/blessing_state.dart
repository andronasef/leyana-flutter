part of 'blessing_cubit.dart';

@immutable
sealed class BlessingState {}

final class BlessingInitial extends BlessingState {}

final class BlessingLoading extends BlessingState {}

final class BlessingLoaded extends BlessingState {
  final BlessingDBModel blessing;

  BlessingLoaded(this.blessing);
}

final class BlessingError extends BlessingState {
  final String message;

  BlessingError(this.message);
}
