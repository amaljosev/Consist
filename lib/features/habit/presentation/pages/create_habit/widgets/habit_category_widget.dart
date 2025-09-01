import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/core/utils/common_functions.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/bloc/create_bloc.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_create_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitCategoryWidget extends StatelessWidget {
  const HabitCategoryWidget({
    super.key,
    required this.habitCategory,
    required this.isDark,
  });

  final String? habitCategory;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return HabitCreationTile(
      icon: Icons.category_outlined,
      title: 'Habit Category',
      trailing: CommonFunctions.getCategoryNameById(habitCategory ?? ''),
      onTap: () => showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (ctx) => Container(
          color: isDark ? Theme.of(context).colorScheme.surface : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(HabitsItems.habitCategories.length-1, (
                    index,
                  ) {
                    final item = HabitsItems.habitCategories[index+1];
                    final name = item['name'];
                    return ListTile(
                      trailing: Icon(item['icon']),
                      title: Text(name ?? ''),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      onTap: () {
                        context.read<CreateBloc>().add(
                          UpdateHabitCategoryEvent(item['id'] ?? '0'),
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
      ),
    );
  }
}
