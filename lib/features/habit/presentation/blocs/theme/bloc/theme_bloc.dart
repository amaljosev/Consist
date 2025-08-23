import 'package:consist/features/habit/domain/theme/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository repository;

  ThemeBloc({required this.repository}) : super(ThemeInitial()) {
    on<LoadThemeEvent>((event, emit) async {
      final isDark = await repository.isDarkMode();
      emit(ThemeLoaded(isDark ? ThemeMode.dark : ThemeMode.light));
    });

    on<ToggleThemeEvent>((event, emit) async {
      if (state is ThemeLoaded) {
        final currentMode = (state as ThemeLoaded).mode;
        final newMode = currentMode == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark;
        await repository.setDarkMode(newMode == ThemeMode.dark);
        emit(ThemeLoaded(newMode));
      }
    });
  }
}
