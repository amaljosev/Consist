import 'package:flutter/material.dart';

class DashboardPreviewScreen extends StatelessWidget {
  const DashboardPreviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=800&q=80',
            height: 200,
          ),
          const SizedBox(height: 30),
          const Text(
            'Your Personal Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Track progress, write reflections, and see your growth over time',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Today\'s Habits',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Chip(
                      backgroundColor: const Color(0xFF4361EE).withOpacity(0.1),
                      label: const Text(
                        '4/6 completed',
                        style: TextStyle(color: Color(0xFF4361EE)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _DashboardHabitItem(name: 'Morning Meditation', completed: true),
                _DashboardHabitItem(name: 'Drink 8 glasses of water', completed: true),
                _DashboardHabitItem(name: '30 min exercise', completed: true),
                _DashboardHabitItem(name: 'Read 20 pages', completed: true),
                _DashboardHabitItem(name: 'Journaling', completed: false),
                _DashboardHabitItem(name: 'No sugar', completed: false),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Reflection',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'What went well today? What could be improved?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Today I managed to complete most of my habits. I felt especially good after meditation...',
                  style: TextStyle(fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardHabitItem extends StatelessWidget {
  final String name;
  final bool completed;
  const _DashboardHabitItem({
    required this.name,
    required this.completed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: completed ? const Color(0xFF38B000) : Colors.transparent,
              border: Border.all(
                color: completed ? const Color(0xFF38B000) : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: completed
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              decoration: completed ? TextDecoration.lineThrough : null,
              color: completed ? Colors.grey : const Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}
