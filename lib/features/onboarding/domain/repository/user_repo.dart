import 'package:consist/features/onboarding/domain/entities/user_analytics_model.dart';

abstract class UserRepository {
  // User setup
  Future<String> setupUser({String? username, String? avatar});
  Future<bool> isUserSetupRequired();
  
  // User operations
  Future<UserAnalytics?> getCurrentUser();
  Future<int> updateUser(UserAnalytics user);
  Future<int> deleteUser();
  
  // Analytics operations
  Future<int> updateLastLogin();
  Future<int> updateStreak();
  Future<int> resetCurrentStreak();
  Future<int> incrementDaysActive();
  Future<bool> checkAndUpdateDailyStats();
  
  // Achievements
  Future<int> addAchievement(int achievementId);
  Future<int> removeAchievement(int achievementId);
  Future<bool> hasAchievement(int achievementId);
  Future<List<int>> getUserAchievements();
  Future<int> getAchievementCount();
  Future<int> clearAllAchievements();
  
  // Stars
  Future<int> addStars(int count);
  
  // User data
  Future<UserAnalytics?> getUserProfile();
  Future<Map<String, dynamic>> getUserStats();
  Future<bool> userExists();
}