part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final ThemeData themeData;

  ThemeChanged({required this.themeData});
}
