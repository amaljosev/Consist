part of 'theme_bloc.dart';

abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeMode mode;
  ThemeLoaded(this.mode);
}
