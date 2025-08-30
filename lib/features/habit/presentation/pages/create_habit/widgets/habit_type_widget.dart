import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/bloc/create_bloc.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_create_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitTypeWidget extends StatelessWidget {
  const HabitTypeWidget({
    super.key,
    required this.habitType,
    required this.isDark,
  });

  final String? habitType;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return HabitCreationTile(
      icon: Icons.list,
      title: 'Habit Type',
      trailing: habitType,
      onTap: () => showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (ctx) => Container(
          color: isDark ? Theme.of(context).colorScheme.surface : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(HabitType.values.length, (index) {
                  final item = HabitType.values[index];
                  return ListTile(
                    title: Text(
                      item == HabitType.develop
                          ? 'Develop'
                          : item == HabitType.quit
                          ? 'Quit'
                          : 'Single Task',
                    ),
                    trailing: Icon(
                      item == HabitType.develop
                          ? Icons.flag_outlined
                          : item == HabitType.quit
                          ? Icons.dangerous_outlined
                          : Icons.add_task_outlined,
                    ),
                    onTap: () {
                      context.read<CreateBloc>().add(
                        UpdateHabitTypeEvent(item.name),
                      );
                      Navigator.pop(context);
                    },
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
