import 'package:flutter/material.dart';

class HabitSelectionScreen extends StatefulWidget {
  const HabitSelectionScreen({super.key});

  @override
  State<HabitSelectionScreen> createState() => _HabitSelectionScreenState();
}

class _HabitSelectionScreenState extends State<HabitSelectionScreen> {
  final List<Map<String, dynamic>> _habitCategories = [
    {
      'title': 'Health & Wellness',
      'habits': [
        {
          'name': 'Meditation',
          'selected': false,
          'icon': Icons.self_improvement,
        },
        {'name': 'Exercise', 'selected': false, 'icon': Icons.directions_run},
        {'name': 'Drink Water', 'selected': false, 'icon': Icons.local_drink},
        {'name': 'Sleep 8 Hours', 'selected': false, 'icon': Icons.nightlight},
      ],
    },
    {
      'title': 'Productivity',
      'habits': [
        {'name': 'Read Daily', 'selected': false, 'icon': Icons.menu_book},
        {'name': 'Plan Day', 'selected': false, 'icon': Icons.calendar_today},
        {'name': 'Learn Something', 'selected': false, 'icon': Icons.school},
        {'name': 'Focus Time', 'selected': false, 'icon': Icons.timer},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
            height: 180,
          ),
          const SizedBox(height: 20),
          const Text(
            'Choose Your Habits',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Select habits you want to build or use our templates to get started',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _habitCategories.length,
              itemBuilder: (context, categoryIndex) {
                final category = _habitCategories[categoryIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
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
                      itemCount: (category['habits'] as List).length,
                      itemBuilder: (context, habitIndex) {
                        final habit = category['habits'][habitIndex];
                        return _HabitChip(
                          name: habit['name'],
                          icon: habit['icon'],
                          selected: habit['selected'],
                          onTap: () {
                            setState(() {
                              habit['selected'] = !habit['selected'];
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ],
      ),
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
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF4361EE) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? const Color(0xFF4361EE) : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : const Color(0xFF4361EE),
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
