import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/features/habit/presentation/blocs/habits_bloc/habits_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitCategoriesSlider extends StatelessWidget {
  const HabitCategoriesSlider({super.key, required this.selectedCategoryId});

  final String selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: HabitsItems.habitCategories.length,
        itemBuilder: (context, index) {
          final category = HabitsItems.habitCategories[index];
          final isSelected = category["id"] == selectedCategoryId;

          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              child: FilterChip(
                label: Text(
                  category["name"],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),

                selected: isSelected,
                onSelected: isSelected
                    ? (_) {}
                    : (value) {
                        if (category["name"] == "all") {
                          context.read<HabitsBloc>().add(LoadHabitsEvent());
                        } else {
                          context.read<HabitsBloc>().add(
                            FetchHabitsByCategory(category["id"]),
                          );
                        }
                      },
                avatar: Icon(
                  category["icon"],
                  color: isSelected ? Colors.white : Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(color: Colors.transparent),
                ),

                backgroundColor: Colors.white,
                showCheckmark: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
