import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/bloc/create_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitIcon extends StatelessWidget {
  const HabitIcon({super.key, required this.isDark, required this.icon});

  final bool isDark;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (ctx) => Container(
            color: isDark
                ? Theme.of(context).colorScheme.surface
                : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SafeArea(
                bottom: true,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(HabitsItems.habitIcons.length, (
                    index,
                  ) {
                    final icon = HabitsItems.habitIcons[index];
                    return GestureDetector(
                      onTap: () {
                        context.read<CreateBloc>().add(
                          UpdateHabitIconEvent(icon),
                        );
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black12,
                        child: Icon(
                          icon,
                          color: isDark
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
      icon: Icon(
        icon,
        color: Theme.of(context).primaryColor,
        size: MediaQuery.of(context).size.width * 0.2,
      ),
    );
  }
}
