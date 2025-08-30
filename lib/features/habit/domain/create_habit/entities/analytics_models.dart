import 'dart:convert';

class HabitAnalytics {
  final int currentStreak;
  final int bestStreak;
  final List<int> mostActiveDays; // weekdays 0=Sun...6=Sat
  final double completionRate;
  final double weeklyCompletionRate;
  final double monthlyCompletionRate;
  final double yearlyCompletionRate;
  final int starsEarned;

  const HabitAnalytics({
    required this.currentStreak,
    required this.bestStreak,
    required this.mostActiveDays,
    required this.completionRate,
    required this.weeklyCompletionRate,
    required this.monthlyCompletionRate,
    required this.yearlyCompletionRate,
    required this.starsEarned,
  });

  /// ✅ Convert to Map for DB (all fields as String)
  Map<String, dynamic> toMap() {
    return {
      'currentStreak': currentStreak.toString(),
      'bestStreak': bestStreak.toString(),
      'mostActiveDays': jsonEncode(mostActiveDays),
      'completionRate': completionRate.toString(),
      'weeklyCompletionRate': weeklyCompletionRate.toString(),
      'monthlyCompletionRate': monthlyCompletionRate.toString(),
      'yearlyCompletionRate': yearlyCompletionRate.toString(),
      'starsEarned': starsEarned.toString(),
    };
  }

  /// ✅ Create from DB Map (decode strings to proper types)
  factory HabitAnalytics.fromMap(Map<String, dynamic> map) {
    return HabitAnalytics(
      currentStreak: int.parse(map['currentStreak']),
      bestStreak: int.parse(map['bestStreak']),
      mostActiveDays: List<int>.from(jsonDecode(map['mostActiveDays'])),
      completionRate: double.parse(map['completionRate']),
      weeklyCompletionRate: double.parse(map['weeklyCompletionRate']),
      monthlyCompletionRate: double.parse(map['monthlyCompletionRate']),
      yearlyCompletionRate: double.parse(map['yearlyCompletionRate']),
      starsEarned: int.parse(map['starsEarned']),
    );
  }
}
