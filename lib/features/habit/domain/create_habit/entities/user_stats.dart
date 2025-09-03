
class UserStatsFields {
  static const String id = "id";
  static const String commonStreak = "commonStreak";
  static const String bestStreak = "bestStreak";
  static const String lastLoginDate = "lastLoginDate";
  static const String completionRate = "completionRate";
  static const String weeklyProgress = "weeklyProgress";
  static const String monthlyProgress = "monthlyProgress";
  static const String yearlyProgress = "yearlyProgress";
  static const String mostActiveDays = "mostActiveDays";
  static const String stars = "stars";
  static const String totalHabitsCompleted = "totalHabitsCompleted";
  static const String longestHabit = "longestHabit";
  static const String averageDailyHabits = "averageDailyHabits";
  static const String createdAt = "createdAt";
  static const String updatedAt = "updatedAt";

  static List<String> get values => [
        id,
        commonStreak,
        bestStreak,
        lastLoginDate,
        completionRate,
        weeklyProgress,
        monthlyProgress,
        yearlyProgress,
        mostActiveDays,
        stars,
        totalHabitsCompleted,
        longestHabit,
        averageDailyHabits,
        createdAt,
        updatedAt,
      ];
}

const String tableUserStats = "user_stats";

class UserStatsModel {
  final int? id;
  final int commonStreak;
  final int bestStreak;
  final String? lastLoginDate;
  final double completionRate;
  final String? weeklyProgress;
  final String? monthlyProgress;
  final String? yearlyProgress;
  final String? mostActiveDays;
  final int stars;
  final int totalHabitsCompleted;
  final String? longestHabit;
  final double averageDailyHabits;
  final String? createdAt;
  final String? updatedAt;

  const UserStatsModel({
    this.id,
    required this.commonStreak,
    required this.bestStreak,
    this.lastLoginDate,
    required this.completionRate,
    this.weeklyProgress,
    this.monthlyProgress,
    this.yearlyProgress,
    this.mostActiveDays,
    required this.stars,
    required this.totalHabitsCompleted,
    this.longestHabit,
    required this.averageDailyHabits,
    this.createdAt,
    this.updatedAt,
  });

  /// 👇 Add this
  UserStatsModel copyWith({
    int? id,
    int? commonStreak,
    int? bestStreak,
    String? lastLoginDate,
    double? completionRate,
    String? weeklyProgress,
    String? monthlyProgress,
    String? yearlyProgress,
    String? mostActiveDays,
    int? stars,
    int? totalHabitsCompleted,
    String? longestHabit,
    double? averageDailyHabits,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserStatsModel(
      id: id ?? this.id,
      commonStreak: commonStreak ?? this.commonStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      completionRate: completionRate ?? this.completionRate,
      weeklyProgress: weeklyProgress ?? this.weeklyProgress,
      monthlyProgress: monthlyProgress ?? this.monthlyProgress,
      yearlyProgress: yearlyProgress ?? this.yearlyProgress,
      mostActiveDays: mostActiveDays ?? this.mostActiveDays,
      stars: stars ?? this.stars,
      totalHabitsCompleted: totalHabitsCompleted ?? this.totalHabitsCompleted,
      longestHabit: longestHabit ?? this.longestHabit,
      averageDailyHabits: averageDailyHabits ?? this.averageDailyHabits,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, Object?> toJson() => {
        UserStatsFields.id: id,
        UserStatsFields.commonStreak: commonStreak,
        UserStatsFields.bestStreak: bestStreak,
        UserStatsFields.lastLoginDate: lastLoginDate,
        UserStatsFields.completionRate: completionRate,
        UserStatsFields.weeklyProgress: weeklyProgress,
        UserStatsFields.monthlyProgress: monthlyProgress,
        UserStatsFields.yearlyProgress: yearlyProgress,
        UserStatsFields.mostActiveDays: mostActiveDays,
        UserStatsFields.stars: stars,
        UserStatsFields.totalHabitsCompleted: totalHabitsCompleted,
        UserStatsFields.longestHabit: longestHabit,
        UserStatsFields.averageDailyHabits: averageDailyHabits,
        UserStatsFields.createdAt: createdAt,
        UserStatsFields.updatedAt: updatedAt,
      };

  static UserStatsModel fromJson(Map<String, Object?> json) => UserStatsModel(
        id: json[UserStatsFields.id] as int?,
        commonStreak: json[UserStatsFields.commonStreak] as int,
        bestStreak: json[UserStatsFields.bestStreak] as int,
        lastLoginDate: json[UserStatsFields.lastLoginDate] as String?,
        completionRate: (json[UserStatsFields.completionRate] as num).toDouble(),
        weeklyProgress: json[UserStatsFields.weeklyProgress] as String?,
        monthlyProgress: json[UserStatsFields.monthlyProgress] as String?,
        yearlyProgress: json[UserStatsFields.yearlyProgress] as String?,
        mostActiveDays: json[UserStatsFields.mostActiveDays] as String?,
        stars: json[UserStatsFields.stars] as int,
        totalHabitsCompleted: json[UserStatsFields.totalHabitsCompleted] as int,
        longestHabit: json[UserStatsFields.longestHabit] as String?,
        averageDailyHabits:
            (json[UserStatsFields.averageDailyHabits] as num).toDouble(),
        createdAt: json[UserStatsFields.createdAt] as String?,
        updatedAt: json[UserStatsFields.updatedAt] as String?,
      );
}
