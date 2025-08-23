import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/bloc/create_bloc.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_create_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitTimeWidget extends StatelessWidget {
  const HabitTimeWidget({super.key, required this.habitTime});

  final String? habitTime;

  @override
  Widget build(BuildContext context) {
    return HabitCreationTile(
      icon: Icons.watch_later_outlined,
      title: 'Time',
      trailing: habitTime ?? 'Anytime',
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
                children: List.generate(HabitTiming.values.length, (index) {
                  final value = HabitTiming.values[index];
                  return ListTile(
                    title: Text(value.name),
                    onTap: () {
                      context.read<CreateBloc>().add(
                        UpdateHabitTimeEvent(value.name),
                      );
                      Navigator.of(context).pop();
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