import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/features/habit/presentation/pages/habit_repeat/bloc/repeat_bloc.dart';
import 'package:consist/features/habit/presentation/widgets/app_button.dart';
import 'package:consist/features/habit/presentation/widgets/tab_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitRepeatScreen extends StatelessWidget {
  const HabitRepeatScreen({super.key, this.bgColor});
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RepeatBloc(),
      child: RepeatScreen(bgColor: bgColor),
    );
  }
}

class RepeatScreen extends StatefulWidget {
  const RepeatScreen({super.key, required this.bgColor});
  final Color? bgColor;
  @override
  State<RepeatScreen> createState() => _RepeatScreenState();
}

class _RepeatScreenState extends State<RepeatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        context.read<RepeatBloc>().add(ChangeTabEvent(_tabController.index));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<RepeatBloc, RepeatState>(
      builder: (context, state) {
        String title = "";

        if (state.selectedTab == 0) {
          title = "Repeats every day";
        } else if (state.selectedTab == 1) {
          if (state.selectedWeekdays.isEmpty) {
            title = "Repeats weekly";
          } else {
            title =
                "Repeats every week on ${state.selectedWeekdays.map((d) => HabitsItems.weekdays[d]).join(", ")}";
          }
        } else {
          title = state.selectedDaysOfMonth.isEmpty
              ? "Repeats monthly "
              : "Repeats every month on ${state.selectedDaysOfMonth.join(", ")}";
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: widget.bgColor,
            title: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            elevation: 0,

            foregroundColor: Colors.black,
          ),

          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              spacing: 20,
              children: [
                TabSliderWidget(
                  controller: _tabController,
                  isDark: isDark,
                  tab1: 'Daily',
                  tab2: 'Weekly',
                  tab3: 'Monthly',
                ),

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildDailySelector(context, state),
                      buildWeeklySelector(context, state),
                      buildMonthlySelector(context, state),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            _tabController.index == 0
                                ? {'day': state.intervalNumber}
                                : _tabController.index == 1
                                ? state.selectedWeekdays.isEmpty
                                      ? null
                                      : {'week': state.selectedWeekdays}
                                : state.selectedDaysOfMonth.isEmpty
                                ? null
                                : {'month': state.selectedDaysOfMonth},
                          );
                        },
                        title: 'Submit',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDailySelector(BuildContext context, RepeatState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Interval",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text("Every ${state.intervalNumber} day"),
          ],
        ),
        SizedBox(
          height: 250,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: state.intervalNumber - 1,
            ),
            useMagnifier: true,
            magnification: 1.2,
            itemExtent: 40,
            onSelectedItemChanged: (index) {
              context.read<RepeatBloc>().add(UpdateIntervalEvent(index + 1));
            },
            children: List.generate(
              365,
              (i) => Center(
                child: Text(
                  i + 1 < 10 ? "0${i + 1}" : "${i + 1}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildWeeklySelector(BuildContext context, RepeatState state) {
    final weekdays = ["S", "M", "T", "W", "T", "F", "S"];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Interval",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(() {
              if (state.selectedWeekdays.isEmpty) {
                return "No days selected";
              }
              if (state.selectedWeekdays.length == 2 &&
                  state.selectedWeekdays.contains(0) &&
                  state.selectedWeekdays.contains(6)) {
                return "Every weekend";
              }
              if (state.selectedWeekdays.length == 5 &&
                  state.selectedWeekdays.containsAll({1, 2, 3, 4, 5})) {
                return "Every weekday";
              }
              List<int> sortedDays = state.selectedWeekdays.toList()..sort();
              List<String> dayNames = sortedDays
                  .map((i) => weekdays[i])
                  .toList();
              if (dayNames.length == 2) {
                return "Every ${dayNames[0]} & ${dayNames[1]}";
              }
              return "Every ${dayNames.join(", ")}";
            }()),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (i) {
            bool isSelected = state.selectedWeekdays.contains(i);
            return GestureDetector(
              onTap: () {
                context.read<RepeatBloc>().add(SelectWeekdayEvent(i));
              },
              child: CircleAvatar(
                backgroundColor: isSelected
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.surface,
                child: Text(
                  weekdays[i],
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget buildMonthlySelector(BuildContext context, RepeatState state) {
    const totalDaysInMonth = 31;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Days in Month",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(() {
              if (state.selectedDaysOfMonth.isEmpty) {
                return "No days selected";
              }
              if (state.selectedDaysOfMonth.length == totalDaysInMonth) {
                return "Every day";
              }
              List<int> sortedDays = state.selectedDaysOfMonth.toList()..sort();
              if (sortedDays.length <= 3) {
                return "Every ${sortedDays.join(", ")}";
              } else {
                return "Every ${sortedDays.take(3).join(", ")} & ${sortedDays.length - 3} more";
              }
            }()),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: totalDaysInMonth,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, i) {
            int day = i + 1;
            bool isSelected = state.selectedDaysOfMonth.contains(day);

            return GestureDetector(
              onTap: () {
                context.read<RepeatBloc>().add(SelectMonthDayEvent(day));
              },
              child: CircleAvatar(
                backgroundColor: isSelected
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.surface,
                child: Text(
                  "$day",
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
