import 'dart:convert';
import 'package:consist/features/habit/domain/create_habit/entities/habit_model.dart';

class HabitAnalytics {
  final String habitId;
  final String lastDay;
  final int currentStreak;
  final int bestStreak;
  final List<int> mostActiveDays;
  final double completionRate;
  final double weeklyCompletionRate;
  final double monthlyCompletionRate;
  final double yearlyCompletionRate;
  final int starsEarned;
  final List<int> achievements;
  final String createdAt;
  final String streakStartedAt;

  HabitAnalytics({
    required this.habitId,
    required this.lastDay,
    required this.currentStreak,
    required this.bestStreak,
    required this.mostActiveDays,
    required this.completionRate,
    required this.weeklyCompletionRate,
    required this.monthlyCompletionRate,
    required this.yearlyCompletionRate,
    required this.starsEarned,
    required this.achievements,
    required this.streakStartedAt,
    required this.createdAt,
  });

  HabitAnalytics copyWith({
    String? lastDay,
    int? currentStreak,
    int? bestStreak,
    List<int>? mostActiveDays,
    double? completionRate,
    double? weeklyCompletionRate,
    double? monthlyCompletionRate,
    double? yearlyCompletionRate,
    int? starsEarned,
    List<int>? achievements,
    String? createdAt,
    String? streakStartedAt,
  }) {
    return HabitAnalytics(
      habitId: habitId,
      lastDay: lastDay ?? this.lastDay,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      mostActiveDays: mostActiveDays ?? this.mostActiveDays,
      completionRate: completionRate ?? this.completionRate,
      weeklyCompletionRate: weeklyCompletionRate ?? this.weeklyCompletionRate,
      monthlyCompletionRate:
          monthlyCompletionRate ?? this.monthlyCompletionRate,
      yearlyCompletionRate: yearlyCompletionRate ?? this.yearlyCompletionRate,
      starsEarned: starsEarned ?? this.starsEarned,
      achievements: achievements ?? this.achievements,
      createdAt: createdAt ?? this.createdAt,
      streakStartedAt: streakStartedAt ?? this.streakStartedAt,
    );
  }

  /// ✅ Convert to Map for DB (all fields as String)
  Map<String, dynamic> toMap() {
    return {
      'habitId': habitId,
      'currentStreak': currentStreak.toString(),
      'bestStreak': bestStreak.toString(),
      'mostActiveDays': jsonEncode(mostActiveDays),
      'completionRate': completionRate.toString(),
      'weeklyCompletionRate': weeklyCompletionRate.toString(),
      'monthlyCompletionRate': monthlyCompletionRate.toString(),
      'yearlyCompletionRate': yearlyCompletionRate.toString(),
      'starsEarned': starsEarned.toString(),
      'lastDay': lastDay,
      'achievements': achievements,
      'streakStartedAt': streakStartedAt,
      'createdAt': createdAt,
    };
  }

  /// ✅ Create from DB Map (decode strings to proper types)
  factory HabitAnalytics.fromMap(Map<String, dynamic> map) {
    return HabitAnalytics(
      habitId: map['habitId'] as String,
      createdAt: map['createdAt'] as String,
      streakStartedAt: map['streakStartedAt'] as String,
      currentStreak: int.parse(map['currentStreak']),
      bestStreak: int.parse(map['bestStreak']),
      mostActiveDays: List<int>.from(jsonDecode(map['mostActiveDays'])),
      completionRate: double.parse(map['completionRate']),
      weeklyCompletionRate: double.parse(map['weeklyCompletionRate']),
      monthlyCompletionRate: double.parse(map['monthlyCompletionRate']),
      yearlyCompletionRate: double.parse(map['yearlyCompletionRate']),
      starsEarned: int.parse(map['starsEarned']),
      lastDay: map['lastDay'] as String,
      achievements: List<int>.from(jsonDecode(map['achievements'])),
    );
  }
}

class HabitWithAnalytics {
  final Habit habit;
  final HabitAnalytics analytics;

  HabitWithAnalytics({required this.habit, required this.analytics});
}
