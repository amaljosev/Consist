import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/core/utils/common_functions.dart';
import 'package:consist/core/widgets/loading_widget.dart';
import 'package:consist/features/habit/domain/create_habit/entities/analytics_models.dart';
import 'package:consist/features/habit/presentation/blocs/habits_bloc/habits_bloc.dart';
import 'package:consist/features/habit/presentation/pages/goals/widgets/habit_detail_sheet.dart';
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
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8),
                            itemCount: HabitsItems.habitCategories.length,
                            itemBuilder: (context, index) {
                              final category =
                                  HabitsItems.habitCategories[index];
                              final isSelected =
                                  category["id"] == selectedCategoryId;

                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: GestureDetector(
                                  child: FilterChip(
                                    label: Text(
                                      category["name"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                    ),

                                    selected: isSelected,
                                    onSelected: isSelected
                                        ? (_) {}
                                        : (value) {
                                            if (category["name"] == "all") {
                                              context.read<HabitsBloc>().add(
                                                LoadHabitsEvent(),
                                              );
                                            } else {
                                              context.read<HabitsBloc>().add(
                                                FetchHabitsByCategory(
                                                  category["id"],
                                                ),
                                              );
                                            }
                                          },
                                    avatar: Icon(
                                      category["icon"],
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      side: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),

                                    backgroundColor: Colors.white,
                                    showCheckmark: false,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: habits.isEmpty
                              ? const Center(child: Text("No habits found"))
                              : ListView.builder(
                                  padding: const EdgeInsets.all(5),
                                  itemCount: habits.length,
                                  itemBuilder: (context, index) {
                                    final habit = habits[index];
                                    Color? habitColor =
                                        CommonFunctions.getColorById(
                                          habit.habitColorId ?? "",
                                        ) ??
                                        Theme.of(context).colorScheme.secondary;
                                    Color colorD = CommonFunctions.darken(
                                      habitColor,
                                    );

                                    IconData? habitIcon =
                                        CommonFunctions.getIconById(
                                          habit.habitIconId ?? "",
                                        );
                                    bool isComplete =
                                        CommonFunctions.isNewDayForHabit(
                                          habit.isCompleteToday,
                                        );

                                    return Card(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: ListTile(
                                        leading: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                            color: isDark
                                                ? Colors.white10
                                                : habitColor.withAlpha(128),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Icon(
                                              habitIcon,
                                              color: colorD,
                                            ),
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
                                            habitIcon: habitIcon,
                                          ),
                                          child: Text(
                                            habit.habitName ?? "Unnamed Habit",
                                          ),
                                        ),
                                        titleTextStyle: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              fontWeight: FontWeight.w800,
                                            ),
                                        trailing: GestureDetector(
                                          onTap: () {
                                            final statistics = HabitAnalytics(
                                              currentStreak: 4,
                                              bestStreak: 6,
                                              mostActiveDays: [1, 3, 5],
                                              completionRate: 2.1,
                                              weeklyCompletionRate: 4.2,
                                              monthlyCompletionRate: 1.5,
                                              yearlyCompletionRate: 1.0,
                                              starsEarned: 5,
                                            );
                                            context.read<HabitsBloc>().add(
                                              MarkHabitCompleteEvent(
                                                habitId: habit.id,
                                                analytics: statistics,
                                              ),
                                            );
                                          },
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor: !isComplete
                                                ? colorD
                                                : isDark
                                                ? Colors.white10
                                                : habitColor.withAlpha(128),
                                            child: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
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
