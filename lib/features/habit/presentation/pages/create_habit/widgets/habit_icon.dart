import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/core/utils/common_functions.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/bloc/create_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitIcon extends StatelessWidget {
  const HabitIcon({super.key, required this.isDark, required this.icon});

  final bool isDark;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          isScrollControlled: true,
          builder: (ctx) => SafeArea(
            child: Container(
              color: isDark
                  ? Theme.of(context).colorScheme.surface
                  : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(HabitsItems.habitList.length, (
                    index,
                  ) {
                    final iconData = HabitsItems.habitList[index];
                    final icon = iconData['icon'];
                    return GestureDetector(
                      onTap: () {
                        context.read<CreateBloc>().add(
                          UpdateHabitIconEvent(iconData['id'].toString()),
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
        CommonFunctions.getIconById(icon ?? '0') ?? Icons.favorite_border,
        color: Theme.of(context).primaryColor,
        size: MediaQuery.of(context).size.width * 0.2,
      ),
    );
  }
}
