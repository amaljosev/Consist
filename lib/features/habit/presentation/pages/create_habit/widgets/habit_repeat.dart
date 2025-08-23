import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/bloc/create_bloc.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_create_tile.dart';
import 'package:consist/features/habit/presentation/pages/habit_repeat/bloc/repeat_bloc.dart';
import 'package:consist/features/habit/presentation/pages/habit_repeat/habit_repeat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitRepeatWrapper extends StatelessWidget {
  const HabitRepeatWrapper({super.key, this.habitRepeat, this.bgColor});
  final String? habitRepeat;
  final Color? bgColor;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RepeatBloc(),
      child: HabitRepeatWidget(habitRepeat: habitRepeat, bgColor: bgColor),
    );
  }
}

class HabitRepeatWidget extends StatelessWidget {
  const HabitRepeatWidget({
    super.key,
    required this.habitRepeat,
    required this.bgColor,
  });

  final String? habitRepeat;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return HabitCreationTile(
      icon: Icons.repeat_rounded,
      title: 'Repeat',
      trailing: habitRepeat ?? 'Daily',
      onTap: () => showModalBottomSheet(
        showDragHandle: true,
        context: context,
        builder: (ctx) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(HabitRepeat.values.length, (index) {
                  final value = HabitRepeat.values[index];
                  return ListTile(
                    title: Text(value.name),
                    onTap: () async {
                      if (value.name == 'daily') {
                        context.read<CreateBloc>().add(
                          UpdateHabitRepeatValueEvent('daily'),
                        );
                        Navigator.of(context).pop();
                      } else {
                        Map<String, dynamic>? result =
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    HabitRepeatScreen(bgColor: bgColor),
                              ),
                            );

                        if (result != null) {
                          String repeatValue = '';
                          if (result.keys.first == 'day') {
                            repeatValue = 'Every ${result.values.first} day';
                            context.read<CreateBloc>().add(
                              UpdateRepeatDaysEvent(result.values.first),
                            );
                            context.read<CreateBloc>().add(
                              UpdateHabitRepeatValueEvent(repeatValue),
                            );
                            Navigator.of(context).pop();
                          } else if (result.keys.first == 'month') {
                            List<int> allDays =
                                (result.values.first as Set<int>).toList()
                                  ..sort();
                            if (allDays.length == 31) {
                              repeatValue = 'daily';
                              context.read<CreateBloc>().add(
                                UpdateHabitRepeatValueEvent(repeatValue),
                              );
                              Navigator.of(context).pop();
                            } else if (allDays.length > 5) {
                              String days = allDays.take(3).join(', ');
                              repeatValue = 'Every month on $days & more';
                            } else {
                              String days = allDays.join(', ');
                              repeatValue = 'Every month on $days';
                            }
                            context.read<CreateBloc>().add(
                              UpdateMonthDaysEvent(allDays),
                            );
                            context.read<CreateBloc>().add(
                              UpdateHabitRepeatValueEvent(repeatValue),
                            );
                            Navigator.of(context).pop();
                          } else {
                            List<int> allDays =
                                (result.values.first as Set<int>).toList()
                                  ..sort();
                            if (allDays.length == 2 &&
                                allDays.contains(0) &&
                                allDays.contains(6)) {
                              repeatValue = 'Every Weekend';
                              context.read<CreateBloc>().add(
                                UpdateWeekDaysEvent(allDays),
                              );
                              context.read<CreateBloc>().add(
                                UpdateHabitRepeatValueEvent(repeatValue),
                              );
                              Navigator.of(context).pop();
                            } else if (allDays.length == 5 &&
                                !allDays.contains(0) &&
                                !allDays.contains(6)) {
                              repeatValue = 'Every Weekdays';
                              context.read<CreateBloc>().add(
                                UpdateWeekDaysEvent(allDays),
                              );
                              context.read<CreateBloc>().add(
                                UpdateHabitRepeatValueEvent(repeatValue),
                              );
                              Navigator.of(context).pop();
                            } else if (allDays.length == 7) {
                              repeatValue = 'daily';
                              context.read<CreateBloc>().add(
                                UpdateHabitRepeatValueEvent(repeatValue),
                              );
                              Navigator.of(context).pop();
                            } else {
                              String days = allDays
                                  .map((i) => HabitsItems.weekdays[i])
                                  .join(", ");
                              repeatValue = 'Every week on $days';
                              context.read<CreateBloc>().add(
                                UpdateWeekDaysEvent(allDays),
                              );
                              context.read<CreateBloc>().add(
                                UpdateHabitRepeatValueEvent(repeatValue),
                              );
                              Navigator.of(context).pop();
                            }
                          }
                        } else {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}