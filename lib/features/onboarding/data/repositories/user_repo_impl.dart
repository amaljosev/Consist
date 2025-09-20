import 'dart:developer';
import 'package:consist/features/onboarding/data/datasources/user_datasource.dart';
import 'package:consist/features/onboarding/domain/entities/user_analytics_model.dart';
import 'package:consist/features/onboarding/domain/repository/user_repo.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({required this.localDataSource});

  @override
  Future<String> setupUser({String? username, String? avatar}) async {
    try {
      return await localDataSource.setupUser(username: username, avatar: avatar);
    } catch (e, s) {
      log("Error in setupUser", error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<bool> isUserSetupRequired() async {
    try {
      return await localDataSource.isUserSetupRequired();
    } catch (e, s) {
      log("Error in isUserSetupRequired", error: e, stackTrace: s);
      return true;
    }
  }

  @override
  Future<UserAnalytics?> getCurrentUser() async {
    try {
      return await localDataSource.getCurrentUser();
    } catch (e, s) {
      log("Error in getCurrentUser", error: e, stackTrace: s);
      return null;
    }
  }

  @override
  Future<int> updateUser(UserAnalytics user) async {
    try {
      return await localDataSource.updateUser(user);
    } catch (e, s) {
      log("Error in updateUser", error: e, stackTrace: s);
      return -1;
    }
  }

  @override
  Future<int> deleteUser() async {
    try {
      return await localDataSource.deleteUser();
    } catch (e, s) {
      log("Error in deleteUser", error: e, stackTrace: s);
      return -1;
    }
  }

  @override
  Future<int> updateLastLogin() async {
    try {
      return await localDataSource.updateLastLogin();
    } catch (e, s) {
      log("Error in updateLastLogin", error: e, stackTrace: s);
      return -1;
    }
  }

  @override
  Future<int> updateStreak() async {
    try {
      return await localDataSource.updateStreak();
    } catch (e, s) {
      log("Error in updateStreak", error: e, stackTrace: s);
      return -1;
    }
  }

  @override
  Future<int> resetCurrentStreak() async {
    try {
      return await localDataSource.resetCurrentStreak();
    } catch (e, s) {
      log("Error in resetCurrentStreak", error: e, stackTrace: s);
      return -1;
    }
  }

  @override
  Future<int> incrementDaysActive() async {
    try {
      return await localDataSource.incrementDaysActive();
    } catch (e, s) {
      log("Error in incrementDaysActive", error: e, stackTrace: s);
      return -1;
    }
  }

  @override
  Future<bool> checkAndUpdateDailyStats() async {
    try {
      return await localDataSource.checkAndUpdateDailyStats();
    } catch (e, s) {
      log("Error in checkAndUpdateDailyStats", error: e, stackTrace: s);
       return false;
    }
  }

  @override
  Future<int> addAchievement(int achievementId) async {
    try {
      return await localDataSource.addAchievement(achievementId);
    } catch (e, s) {
      log("Error in addAchievement", error: e, stackTrace: s);
      return -1;
    }
  }

  @override
  Future<int> removeAchievement(int achievementId) async {
    try {
      return await localDataSource.removeAchievement(achievementId);
    } catch (e, s) {
      log("Error in removeAchievement", error: e, stackTrace: s);
      return -1;
    }
  }

  @override
  Future<bool> hasAchievement(int achievementId) async {
    try {
      return await localDataSource.hasAchievement(achievementId);
    } catch (e, s) {
      log("Error in hasAchievement", error: e, stackTrace: s);
      return false;
    }
  }

  @override
  Future<List<int>> getUserAchievements() async {
    try {
      return await localDataSource.getUserAchievements();
    } catch (e, s) {
      log("Error in getUserAchievements", error: e, stackTrace: s);
      return [];
    }
  }

  @override
  Future<int> getAchievementCount() async {
    try {
      return await localDataSource.getAchievementCount();
    } catch (e, s) {
      log("Error in getAchievementCount", error: e, stackTrace: s);
      return 0;
    }
  }

  @override
  Future<int> clearAllAchievements() async {
    try {
      return await localDataSource.clearAllAchievements();
    } catch (e, s) {
      log("Error in clearAllAchievements", error: e, stackTrace: s);
      return -1;
    }
  }

  @override
  Future<int> addStars(int count) async {
    try {
      return await localDataSource.addStars(count);
    } catch (e, s) {
      log("Error in addStars", error: e, stackTrace: s);
      return -1;
    }
  }

  @override
  Future<UserAnalytics?> getUserProfile() async {
    try {
      return await localDataSource.getUserProfile();
    } catch (e, s) {
      log("Error in getUserProfile", error: e, stackTrace: s);
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> getUserStats() async {
    try {
      return await localDataSource.getUserStats();
    } catch (e, s) {
      log("Error in getUserStats", error: e, stackTrace: s);
      return {};
    }
  }

  @override
  Future<bool> userExists() async {
    try {
      return await localDataSource.userExists();
    } catch (e, s) {
      log("Error in userExists", error: e, stackTrace: s);
      return false;
    }
  }
}
