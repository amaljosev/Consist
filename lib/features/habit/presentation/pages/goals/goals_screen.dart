import 'package:consist/core/widgets/loading_widget.dart';
import 'package:consist/features/habit/presentation/blocs/habits_bloc/habits_bloc.dart';
import 'package:consist/features/habit/presentation/pages/goals/widgets/categories_slider.dart';
import 'package:consist/features/habit/presentation/pages/goals/widgets/goal_list.dart';
import 'package:consist/features/habit/presentation/pages/goals/widgets/new_routine_sheet.dart';
import 'package:consist/features/habit/presentation/pages/goals/widgets/no_habits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HabitsBloc>().add(LoadHabitsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: !isDark
          ? const Color.fromARGB(177, 10, 182, 164)
          : const Color.fromARGB(255, 13, 56, 141),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          header(size, context, isDark),
        ],
        body: BlocConsumer<HabitsBloc, HabitsState>(
          listener: (context, state) {
            if (state is HabitCompleteSuccess) {
              context.read<HabitsBloc>().add(LoadHabitsEvent());
            }
          },
          builder: (context, state) {
            if (state is HabitsLoading) {
              return AppLoading();
            } else if (state is HabitsLoaded) {
              final habits = state.filtered;
              final allHabits = state.habits;

              final selectedCategoryId = state.cat;

              return allHabits.isEmpty
                  ?const NoHabits()
                  : Column(
                      children: [
                        HabitCategoriesSlider(selectedCategoryId: selectedCategoryId),
                        GoalsList(habits: habits, isDark: isDark, size: size),
                      ],
                    );
            } else if (state is HabitsError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const Center(
              child: Text("Welcome! Add a habit to get started."),
            );
          },
        ),
      ),
      floatingActionButton: NewRoutine(isDark: isDark),
    );
  }
}

SliverAppBar header(Size size, BuildContext context, bool isDark) {
  return SliverAppBar.large(
    expandedHeight: size.height * 0.1,
    backgroundColor: Theme.of(context).colorScheme.surface,
    flexibleSpace: FlexibleSpaceBar(
      background: Image.asset(
        isDark
            ? 'assets/img/dashboard_dark.png'
            : 'assets/img/dashboard_light.png',
        fit: BoxFit.cover,
      ),
      expandedTitleScale: 1.0,
      stretchModes: [StretchMode.zoomBackground],
    ),
    title: const Text('Small steps, big results. Keep going!'),
    automaticallyImplyLeading: false,
    elevation: 0,
    pinned: true,
  );
}
