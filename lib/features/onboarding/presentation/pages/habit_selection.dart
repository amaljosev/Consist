import 'package:consist/core/constants/habits_items.dart';
import 'package:flutter/material.dart';

class HabitSelectionScreen extends StatefulWidget {
  const HabitSelectionScreen({super.key});

  @override
  State<HabitSelectionScreen> createState() => _HabitSelectionScreenState();
}

class _HabitSelectionScreenState extends State<HabitSelectionScreen> {
  // track selected habits by id
  final Set<String> _selectedHabits = {};

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
       SliverAppBar(
        toolbarHeight: 310,
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
          background: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/img/onboarding/onboarding4.png',
                  height: 180),
              const SizedBox(height: 20),
              Text(
                'Choose Your Habits',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(
                'Select habits you want to build or use our templates to get started',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
       ),
    
        // Categories + Habits
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, categoryIndex) {
              final category = HabitsItems.habitCategories[categoryIndex];
    
              // Skip "All" (id:0) if you don’t want to show it
              if (category['id'] == '0') return const SizedBox();
    
              // Get all habits for this category
              final habits = HabitsItems.habitList
                  .where((h) => h['categoryId'] == category['id'])
                  .toList();
    
              if (habits.isEmpty) return const SizedBox();
    
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          category['icon'],
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category['name'],
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3,
                      ),
                      itemCount: habits.length,
                      itemBuilder: (context, habitIndex) {
                        final habit = habits[habitIndex];
                        final isSelected =
                            _selectedHabits.contains(habit['id']);
                        return _HabitChip(
                          name: habit['name'],
                          icon: habit['icon'],
                          selected: isSelected,
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedHabits.remove(habit['id']);
                              } else {
                                _selectedHabits.add(habit['id']);
                              }
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
            childCount: HabitsItems.habitCategories.length,
          ),
        ),
      ],
    );
  }
}


class _HabitChip extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _HabitChip({
    required this.name,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,

                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: selected ? Colors.white : const Color(0xFF333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

