import 'package:consist/features/habit/presentation/blocs/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(onPressed: (){
        context.read<ThemeBloc>().add(ToggleThemeEvent());
      }),
      ),
    );
  }
}