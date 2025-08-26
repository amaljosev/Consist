import 'package:consist/core/app_theme.dart';
import 'package:consist/features/habit/data/datasources/habit_local_datasource.dart';
import 'package:consist/features/habit/data/repositories/habit_repository_impl.dart';
import 'package:consist/features/habit/domain/create_habit/repositories/habit_repository.dart';
import 'package:consist/features/habit/presentation/blocs/habits_bloc/habits_bloc.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/bloc/create_bloc.dart';
import 'package:consist/features/habit/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize datasource
  final habitLocalDataSource = HabitDatabase.instance;

  // Repository layer
  final HabitRepository habitRepository = HabitRepositoryImpl(
    db: habitLocalDataSource,
  );
  runApp(MyApp(habitRepo: habitRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.habitRepo});
  final HabitRepository habitRepo;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HabitsBloc(habitRepository: habitRepo),
        ),
        BlocProvider(create: (context) => CreateBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
