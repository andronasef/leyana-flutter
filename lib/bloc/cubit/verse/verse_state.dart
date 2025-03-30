part of 'verse_cubit.dart';

sealed class VerseState {}

final class VerseInitial extends VerseState {}

final class VerseLoading extends VerseState {}

final class VerseLoaded extends VerseState {
  final VerseDBModel randomVerse;

  VerseLoaded(this.randomVerse);
}

final class VerseError extends VerseState {
  final String message;

  VerseError(this.message);
}
