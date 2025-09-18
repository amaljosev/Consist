import 'package:consist/core/app_icons.dart';
import 'package:consist/features/habit/presentation/blocs/habits_bloc/habits_bloc.dart';
import 'package:consist/features/habit/presentation/pages/goals/widgets/no_habits.dart';
import 'package:consist/features/habit/presentation/pages/me/me_screen.dart';
import 'package:consist/features/diary/presentation/pages/diary_screen.dart';
import 'package:consist/features/habit/presentation/pages/goals/goals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    GoalsScreen(),
    HabitLibrary(fromHome: true),
    DiaryScreen(),
    MeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HabitsBloc, HabitsState>(
      listener: (context, state) {
        if (state is BottomNavScreenChangeState) {
          _selectedIndex = state.index;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) =>_selectedIndex!=index? context.read<HabitsBloc>().add(
              BottomNavScreenChangeEvent(index: index),
            ):null,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.tasks),
                label: 'Goals',
                
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined),
                label: 'Diary',
              ),
              BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.user),
                label: 'Me',
              ),
            ],
          ),
        );
      },
    );
  }
}
