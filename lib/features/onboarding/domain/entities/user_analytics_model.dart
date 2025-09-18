class UserAnalytics {
  final String userId;
  final String username;
  final String avatar;
  final String installedDate;
  final String lastLogin;
  final String lastCompleted;
  final int bestStreak;
  final int currentStreak;
  final int totalDaysActive;
  final List<int> achievements; 
  final int stars;

  UserAnalytics({
    required this.userId,
    required this.username,
    required this.avatar,
    required this.installedDate,
    required this.lastLogin,
    required this.lastCompleted,
    this.bestStreak = 0,
    this.currentStreak = 0,
    this.totalDaysActive = 0,
    this.achievements = const [],
    this.stars = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'avatar': avatar,
      'installedDate': installedDate,
      'lastLogin': lastLogin,
      'lastCompleted': lastCompleted,
      'bestStreak': bestStreak,
      'currentStreak': currentStreak,
      'totalDaysActive': totalDaysActive,
      'achievements': encodeAchievements(achievements), 
      'stars': stars,
    };
  }

  factory UserAnalytics.fromMap(Map<String, dynamic> map) {
    return UserAnalytics(
      userId: map['userId'],
      username: map['username'],
      avatar: map['avatar'],
      installedDate: map['installedDate'],
      lastLogin: map['lastLogin'],
      lastCompleted: map['lastCompleted'],
      bestStreak: map['bestStreak'],
      currentStreak: map['currentStreak'],
      totalDaysActive: map['totalDaysActive'],
      achievements: decodeAchievements(map['achievements']), 
      stars: map['stars'],
    );
  }

  // Helper methods for JSON encoding/decoding
  static String encodeAchievements(List<int> achievements) {
    return achievements.join(',');
  }

  static List<int> decodeAchievements(dynamic achievementsData) {
    if (achievementsData == null || achievementsData == '') {
      return [];
    }
    if (achievementsData is String) {
      return achievementsData.split(',').map((e) => int.tryParse(e) ?? 0).toList();
    }
    return [];
  }
}