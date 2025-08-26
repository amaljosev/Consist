import 'package:consist/core/utils/common_functions.dart';
import 'package:consist/core/widgets/loading_widget.dart';
import 'package:consist/features/habit/presentation/blocs/habits_bloc/habits_bloc.dart';
import 'package:consist/features/habit/presentation/pages/routine/widgets/habit_detail_sheet.dart';
import 'package:consist/features/habit/presentation/pages/routine/widgets/new_routine_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  bool isComplete = false;
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
        body: BlocBuilder<HabitsBloc, HabitsState>(
          builder: (context, state) {
            if (state is HabitsLoading) {
              return AppLoading();
            } else if (state is HabitsLoaded) {
              final habits = state.habits;

              if (habits.isEmpty) {
                return const Center(child: Text("No habits found"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  Color? habitColor =
                      CommonFunctions.getColorById(habit.habitColorId!) ??
                      Theme.of(context).colorScheme.secondary;
                  Color colorD = CommonFunctions.darken(habitColor);
                  IconData? habitIcon = CommonFunctions.getIconById(
                    habit.habitIconId!,
                  );
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),

                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: isDark
                              ? Colors.white10
                              : habitColor.withValues(alpha: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(habitIcon, color: colorD),
                        ),
                      ),
                      title: GestureDetector(
                        onTap: () => habitDetailSheet(
                          context: context,
                          size: size,
                          habitColor: habitColor,
                          colorD: colorD,
                          habit: habit,
                          isDark: isDark,
                          habitIcon: habitIcon
                        ),
                        child: Text(habit.habitName ?? "Unnamed Habit"),
                      ),
                      titleTextStyle: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w800),
                      trailing: CircleAvatar(
                        radius: 16,
                        backgroundColor: isComplete
                            ? colorD
                            : isDark
                            ? Colors.white10
                            : habitColor.withValues(alpha: 0.5),
                        child: const Icon(Icons.check, color: Colors.white),
                      ),
                    ),
                  );
                },
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
}
