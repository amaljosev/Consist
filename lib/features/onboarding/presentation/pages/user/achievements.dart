import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = _achievements.map((e) => e.category).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievements"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final items = getAchievementsByCategory(category);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
              ),
              const SizedBox(height: 12),
              ...items.map((a) => AchievementTile(achievement: a)).toList(),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

class AchievementTile extends StatelessWidget {
  final Achievement achievement;

  // For now, using static progress. Replace with actual user streak.
  final int currentStreak = 2;

  const AchievementTile({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final progress = getAchievementProgress(achievement, currentStreak);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Text(
          achievement.icon,
          style: const TextStyle(fontSize: 32),
        ),
        title: Text(
          achievement.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(achievement.description),
            const SizedBox(height: 8),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: progress),
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: 8,
                borderRadius: BorderRadius.circular(8),
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  progress >= 1 ? Colors.green : Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text("${(progress * 100).toInt()}% • "
                "Streak: $currentStreak/${achievement.requiredStreak}"),
          ],
        ),
      ),
    );
  }
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final int requiredStreak;
  final String category;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.requiredStreak,
    required this.category,
  });
}

// ---- Your Achievements Data (shortened for demo) ----
final List<Achievement> _achievements = [
  // Beginner Achievements
  Achievement(
    id: 'beginner_1',
    title: 'First Steps',
    description: 'Complete your very first habit',
    icon: '👣',
    requiredStreak: 1,
    category: 'beginner',
  ),
  Achievement(
    id: 'beginner_2',
    title: 'Rookie',
    description: 'Complete 5 habits total',
    icon: '🌱',
    requiredStreak: 5,
    category: 'beginner',
  ),
  Achievement(
    id: 'beginner_3',
    title: 'Early Riser',
    description: 'Complete a morning habit 3 days in a row',
    icon: '🌅',
    requiredStreak: 3,
    category: 'beginner',
  ),
  Achievement(
    id: 'beginner_4',
    title: 'Consistency Starter',
    description: 'Maintain a 3-day streak on any habit',
    icon: '📈',
    requiredStreak: 3,
    category: 'beginner',
  ),
  Achievement(
    id: 'beginner_5',
    title: 'Multi-Tasker',
    description: 'Create 3 different habits',
    icon: '🔄',
    requiredStreak: 3,
    category: 'beginner',
  ),

  // Weekly Achievements
  Achievement(
    id: 'weekly_1',
    title: 'Week Warrior',
    description: 'Maintain a 7-day streak',
    icon: '⚔️',
    requiredStreak: 7,
    category: 'weekly',
  ),
  Achievement(
    id: 'weekly_2',
    title: 'Perfect Week',
    description: 'Complete all habits for 7 consecutive days',
    icon: '✅',
    requiredStreak: 7,
    category: 'weekly',
  ),
  Achievement(
    id: 'weekly_3',
    title: 'Weekend Champion',
    description: 'Complete habits on both weekend days',
    icon: '🎯',
    requiredStreak: 2,
    category: 'weekly',
  ),
  Achievement(
    id: 'weekly_4',
    title: 'Morning Person',
    description: 'Complete morning habits for 7 days straight',
    icon: '☀️',
    requiredStreak: 7,
    category: 'weekly',
  ),
  Achievement(
    id: 'weekly_5',
    title: 'Evening Routine',
    description: 'Complete evening habits for 7 days straight',
    icon: '🌙',
    requiredStreak: 7,
    category: 'weekly',
  ),

  // Monthly Achievements
  Achievement(
    id: 'monthly_1',
    title: 'Month Master',
    description: 'Maintain a 30-day streak',
    icon: '👑',
    requiredStreak: 30,
    category: 'monthly',
  ),
  Achievement(
    id: 'monthly_2',
    title: '30-Day Challenge',
    description: 'Complete a habit every day for a month',
    icon: '📅',
    requiredStreak: 30,
    category: 'monthly',
  ),
  Achievement(
    id: 'monthly_3',
    title: 'Calendar Crusher',
    description: 'No missed days for an entire month',
    icon: '🗓️',
    requiredStreak: 30,
    category: 'monthly',
  ),
  Achievement(
    id: 'monthly_4',
    title: 'Habit Builder',
    description: 'Maintain 3 different habits for 30 days',
    icon: '🏗️',
    requiredStreak: 30,
    category: 'monthly',
  ),
  Achievement(
    id: 'monthly_5',
    title: 'Monthly MVP',
    description: '100% completion rate for a month',
    icon: '⭐',
    requiredStreak: 30,
    category: 'monthly',
  ),

  // Quarterly Achievements
  Achievement(
    id: 'quarterly_1',
    title: '90-Day Wonder',
    description: 'Maintain a 90-day streak',
    icon: '✨',
    requiredStreak: 90,
    category: 'quarterly',
  ),
  Achievement(
    id: 'quarterly_2',
    title: 'Seasoned Veteran',
    description: 'Complete habits for an entire season',
    icon: '🍂',
    requiredStreak: 90,
    category: 'quarterly',
  ),
  Achievement(
    id: 'quarterly_3',
    title: 'Triple Threat',
    description: 'Maintain 3 habits for 90 days straight',
    icon: '🔺',
    requiredStreak: 90,
    category: 'quarterly',
  ),

  // Yearly Achievements
  Achievement(
    id: 'yearly_1',
    title: 'Habit Hero',
    description: 'Maintain a 365-day streak',
    icon: '🦸',
    requiredStreak: 365,
    category: 'yearly',
  ),
  Achievement(
    id: 'yearly_2',
    title: 'Year of Growth',
    description: 'Complete habits for an entire year',
    icon: '🌳',
    requiredStreak: 365,
    category: 'yearly',
  ),
  Achievement(
    id: 'yearly_3',
    title: '365 Champion',
    description: 'Perfect completion for a full year',
    icon: '🏆',
    requiredStreak: 365,
    category: 'yearly',
  ),

  // Special & Themed Achievements
  Achievement(
    id: 'special_1',
    title: 'Early Bird',
    description: 'Complete a habit before 7 AM',
    icon: '🐦',
    requiredStreak: 1,
    category: 'special',
  ),
  Achievement(
    id: 'special_2',
    title: 'Night Owl',
    description: 'Complete a habit after 10 PM',
    icon: '🦉',
    requiredStreak: 1,
    category: 'special',
  ),
  Achievement(
    id: 'special_3',
    title: 'Weekend Warrior',
    description: 'Complete habits on 10 consecutive weekends',
    icon: '💪',
    requiredStreak: 10,
    category: 'special',
  ),
  Achievement(
    id: 'special_4',
    title: 'Habit Collector',
    description: 'Create 10 different habits',
    icon: '📚',
    requiredStreak: 10,
    category: 'special',
  ),
  Achievement(
    id: 'special_5',
    title: 'Completionist',
    description: 'Achieve 100% completion for a week',
    icon: '🎖️',
    requiredStreak: 7,
    category: 'special',
  ),
  Achievement(
    id: 'special_6',
    title: 'Streak Saver',
    description: 'Recover a broken streak within 24 hours',
    icon: '🆘',
    requiredStreak: 1,
    category: 'special',
  ),
  Achievement(
    id: 'special_7',
    title: 'Social Butterfly',
    description: 'Share your progress 5 times',
    icon: '🦋',
    requiredStreak: 5,
    category: 'special',
  ),
  Achievement(
    id: 'special_8',
    title: 'Habit Mixologist',
    description: 'Complete 5 different types of habits',
    icon: '🍹',
    requiredStreak: 5,
    category: 'special',
  ),
  Achievement(
    id: 'special_9',
    title: 'Early Achiever',
    description: 'Unlock 5 achievements',
    icon: '🚀',
    requiredStreak: 5,
    category: 'special',
  ),
  Achievement(
    id: 'special_10',
    title: 'Legendary',
    description: 'Unlock all achievements',
    icon: '🐉',
    requiredStreak: 365,
    category: 'special',
  ),

  // Health & Wellness Focused
  Achievement(
    id: 'health_1',
    title: 'Fitness Fanatic',
    description: 'Complete 30 exercise habits',
    icon: '💪',
    requiredStreak: 30,
    category: 'health',
  ),
  Achievement(
    id: 'health_2',
    title: 'Mindfulness Master',
    description: 'Complete 30 meditation habits',
    icon: '🧘',
    requiredStreak: 30,
    category: 'health',
  ),
  Achievement(
    id: 'health_3',
    title: 'Hydration Hero',
    description: 'Complete 30 water tracking habits',
    icon: '💧',
    requiredStreak: 30,
    category: 'health',
  ),
  Achievement(
    id: 'health_4',
    title: 'Nutrition Ninja',
    description: 'Complete 30 healthy eating habits',
    icon: '🥗',
    requiredStreak: 30,
    category: 'health',
  ),
  Achievement(
    id: 'health_5',
    title: 'Sleep Specialist',
    description: 'Complete 30 sleep tracking habits',
    icon: '😴',
    requiredStreak: 30,
    category: 'health',
  ),

  // Learning & Productivity
  Achievement(
    id: 'learning_1',
    title: 'Bookworm',
    description: 'Complete 30 reading habits',
    icon: '📚',
    requiredStreak: 30,
    category: 'learning',
  ),
  Achievement(
    id: 'learning_2',
    title: 'Language Learner',
    description: 'Complete 30 language practice habits',
    icon: '🗣️',
    requiredStreak: 30,
    category: 'learning',
  ),
  Achievement(
    id: 'learning_3',
    title: 'Coding Champion',
    description: 'Complete 30 coding practice habits',
    icon: '💻',
    requiredStreak: 30,
    category: 'learning',
  ),
  Achievement(
    id: 'learning_4',
    title: 'Productivity Pro',
    description: 'Complete 30 productivity habits',
    icon: '⚡',
    requiredStreak: 30,
    category: 'learning',
  ),
];



// Helper: get by category
List<Achievement> getAchievementsByCategory(String category) {
  return _achievements.where((a) => a.category == category).toList();
}

// Helper: get progress (replace `currentStreak` with real user streak later)
double getAchievementProgress(Achievement achievement, int currentStreak) {
  return (currentStreak / achievement.requiredStreak).clamp(0.0, 1.0);
}
