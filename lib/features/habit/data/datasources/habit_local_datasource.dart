import 'dart:convert';
import 'dart:developer';
import 'package:consist/features/habit/domain/create_habit/entities/analytics_models.dart';
import 'package:consist/features/habit/domain/create_habit/entities/habit_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HabitDatabase {
  static final HabitDatabase instance = HabitDatabase._init();
  static Database? _database;

  HabitDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('habits.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE habits (
          id TEXT PRIMARY KEY,
          habitName TEXT,
          note TEXT,
          habitIconId TEXT,
          category TEXT,
          habitType TEXT,
          habitStartAt TEXT,
          habitTime TEXT,
          habitEndAt TEXT,
          habitRepeatValue TEXT,
          repeatDays TEXT,
          habitRemindTime TEXT,
          habitColorId TEXT,
          isCompleteToday TEXT

        )
      ''');

      await db.execute('''
        CREATE TABLE habit_analytics (
          habitId TEXT PRIMARY KEY,
          lastDay TEXT,
          currentStreak TEXT,
          bestStreak TEXT,
          mostActiveDays TEXT,
          completionRate TEXT,
          weeklyCompletionRate TEXT,
          monthlyCompletionRate TEXT,
          yearlyCompletionRate TEXT,
          starsEarned TEXT,
          achievements TEXT,
          FOREIGN KEY (habitId) REFERENCES habits(id) ON DELETE CASCADE
        )
      ''');
    } catch (e) {
      log("Error creating tables: $e");
    }
  }

  // ✅ Create
  Future<int> createHabit(Habit habit) async {
    try {
      final db = await instance.database;
      return await db
          .insert('habits', {
            'id': habit.id,
            'habitName': habit.habitName,
            'note': habit.note,
            'habitIconId': habit.habitIconId,
            'category': habit.category,
            'habitStartAt': habit.habitStartAt,
            'habitTime': habit.habitTime,
            'habitEndAt': habit.habitEndAt,
            'habitRepeatValue': habit.habitRepeatValue,
            'repeatDays': habit.repeatDays,
            'habitRemindTime': habit.habitRemindTime,
            'habitColorId': habit.habitColorId,
            'isCompleteToday': habit.isCompleteToday,
          })
          .then(
            (value) async => await db.insert('habit_analytics', {
              'habitId': habit.id,
              'currentStreak': '0',
              'bestStreak': '0',
              'mostActiveDays': jsonEncode(<int>[]),
              'completionRate': '0.0',
              'weeklyCompletionRate': '0.0',
              'monthlyCompletionRate': '0.0',
              'yearlyCompletionRate': '0.0',
              'starsEarned': '0',
              'lastDay': '',
              'achievements': jsonEncode(<int>[]),
            }, conflictAlgorithm: ConflictAlgorithm.replace),
          );
    } catch (e) {
      log("Error creating habit: $e");
      return -1;
    }
  }

  // ✅ Read all
  Future<List<Habit>> getAllHabits() async {
    try {
      final db = await instance.database;
      final result = await db.query('habits');

      return result
          .map(
            (map) => Habit(
              id: map['id'] as String,
              habitName: map['habitName'] as String?,
              note: map['note'] as String?,
              habitIconId: map['habitIconId'] as String?,
              category: map['category'] as String?,
              habitStartAt: map['habitStartAt'] as String?,
              habitTime: map['habitTime'] as String?,
              habitEndAt: map['habitEndAt'] as String?,
              habitRepeatValue: map['habitRepeatValue'] as String?,
              repeatDays: map['repeatDays'] as String?,
              habitRemindTime: map['habitRemindTime'] as String?,
              habitColorId: map['habitColorId'] as String?,
              isCompleteToday: map['isCompleteToday'] as String?,
            ),
          )
          .toList();
    } catch (e) {
      log("Error getting all habits: $e");
      return [];
    }
  }

  // ✅ Read one by ID
  Future<Habit?> getHabitById(String id) async {
    try {
      final db = await instance.database;
      final result = await db.query('habits', where: 'id = ?', whereArgs: [id]);
      if (result.isNotEmpty) {
        final map = result.first;
        return Habit(
          id: map['id'] as String,
          habitName: map['habitName'] as String?,
          note: map['note'] as String?,
          habitIconId: map['habitIconId'] as String?,
          habitStartAt: map['habitStartAt'] as String?,
          category: map['category'] as String?,
          habitTime: map['habitTime'] as String?,
          habitEndAt: map['habitEndAt'] as String?,
          habitRepeatValue: map['habitRepeatValue'] as String?,
          repeatDays: map['repeatDays'] as String?,
          habitRemindTime: map['habitRemindTime'] as String?,
          habitColorId: map['habitColorId'] as String?,
          isCompleteToday: map['isCompleteToday'] as String?,
        );
      }
      return null;
    } catch (e) {
      log("Error getting habit by ID: $e");
      return null;
    }
  }

  // ✅ Update
  Future<int> updateHabit(Habit habit) async {
    try {
      final db = await instance.database;
      return await db.update(
        'habits',
        {
          'habitName': habit.habitName,
          'note': habit.note,
          'habitIconId': habit.habitIconId,
          'category': habit.category,
          'habitStartAt': habit.habitStartAt,
          'habitTime': habit.habitTime,
          'habitEndAt': habit.habitEndAt,
          'habitRepeatValue': habit.habitRepeatValue,
          'repeatDays': habit.repeatDays,
          'habitRemindTime': habit.habitRemindTime,
          'habitColorId': habit.habitColorId,
          'isCompleteToday': habit.isCompleteToday,
        },
        where: 'id = ?',
        whereArgs: [habit.id],
      );
    } catch (e) {
      log("Error updating habit: $e");
      return -1;
    }
  }

  // ✅ Delete
  Future<int> deleteHabit(String id) async {
    try {
      final db = await instance.database;
      return await db.delete('habits', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      log("Error deleting habit: $e");
      return -1;
    }
  }

  // ✅ Close DB
  Future close() async {
    try {
      final db = await instance.database;
      await db.close();
    } catch (e) {
      log("Error closing database: $e");
    }
  }

  Future<void> markHabitComplete({
    required String habitId,
    required String completionDate,
    required HabitAnalytics analytics,
  }) async {
    try {
      final db = await instance.database;

      // 1️⃣ Update habit's isCompleteToday
      await db.update(
        'habits',
        {'isCompleteToday': completionDate},
        where: 'id = ?',
        whereArgs: [habitId],
      );

      // 2️⃣ Update habit analytics
      await db.update(
        'habit_analytics',
        {
          'currentStreak': analytics.currentStreak.toString(),
          'bestStreak': analytics.bestStreak.toString(),
          'mostActiveDays': jsonEncode(analytics.mostActiveDays),
          'completionRate': analytics.completionRate.toString(),
          'weeklyCompletionRate': analytics.weeklyCompletionRate.toString(),
          'monthlyCompletionRate': analytics.monthlyCompletionRate.toString(),
          'yearlyCompletionRate': analytics.yearlyCompletionRate.toString(),
          'starsEarned': analytics.starsEarned.toString(),
          'lastDay': analytics.lastDay,
          'achievements': jsonEncode(analytics.achievements),
        },
        where: 'habitId = ?',
        whereArgs: [habitId],
      );
    } catch (e) {
      log("Error marking habit complete: $e");
    }
  }

  // ✅ Get habits by category
  Future<List<Habit>> getHabitsByCategory(String category) async {
    try {
      final db = await instance.database;

      final result = await db.query(
        'habits',
        where: 'category = ?',
        whereArgs: [category],
      );

      if (result.isEmpty) return [];

      return result.map((map) {
        return Habit(
          id: map['id']?.toString() ?? "",
          habitName: map['habitName'] as String?,
          note: map['note'] as String?,
          habitIconId: map['habitIconId'] as String?,
          category: map['category'] as String?,
          habitStartAt: map['habitStartAt'] as String?,
          habitTime: map['habitTime'] as String?,
          habitEndAt: map['habitEndAt'] as String?,
          habitRepeatValue: map['habitRepeatValue'] as String?,
          repeatDays: map['repeatDays'] as String?,
          habitRemindTime: map['habitRemindTime'] as String?,
          habitColorId: map['habitColorId'] as String?,
          isCompleteToday: map['isCompleteToday'] as String?,
        );
      }).toList();
    } catch (e, st) {
      log("Error getting habits by category: $e\n$st");
      return [];
    }
  }

  // ✅ Get habit analytics
  Future<HabitAnalytics?> getHabitAnalytics(String habitId) async {
    try {
      final db = await instance.database;

      final maps = await db.query(
        'habit_analytics',
        where: 'habitId = ?',
        whereArgs: [habitId],
      );

      if (maps.isNotEmpty) {
        return HabitAnalytics.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      log("Error fetching habit analytics: $e");
      return null;
    }
  }

  Future<HabitAnalytics?> calculateUpdatedAnalytics(String habitId) async {
    try {
      final db = await instance.database;

      final maps = await db.query(
        'habit_analytics',
        where: 'habitId = ?',
        whereArgs: [habitId],
      );

      if (maps.isEmpty) return null;

      final current = HabitAnalytics.fromMap(maps.first);

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      DateTime? lastDay;
      if (current.lastDay.isNotEmpty) {
        lastDay = DateTime.tryParse(current.lastDay);
      }

      int currentStreak = current.currentStreak;
      int bestStreak = current.bestStreak;

      // 🔹 Streak logic
      if (lastDay == null) {
        // First ever completion
        currentStreak = 1;
      } else {
        final diff = today
            .difference(DateTime(lastDay.year, lastDay.month, lastDay.day))
            .inDays;

        if (diff == 0) {
          // Already completed today → no update
          return current;
        } else if (diff == 1) {
          currentStreak += 1;
        } else {
          currentStreak = 1; // streak broken, start over
        }
      }

      if (currentStreak > bestStreak) {
        bestStreak = currentStreak;
      }

      // 🔹 Most active days (stored as list<int> or map)
      List<int> mostActiveDays = current.mostActiveDays;
      mostActiveDays.add(today.weekday);

      // 🔹 Completion rate (simplistic increment)
      // For more accuracy, log all completions and calculate on demand.
      double completionRate = (current.completionRate) + 1;

      // 🔹 Weekly/Monthly/Yearly (if you track counts separately)
      double weekly = (current.weeklyCompletionRate) + 1;
      double monthly = (current.monthlyCompletionRate) + 1;
      double yearly = (current.yearlyCompletionRate) + 1;

      return current.copyWith(
        lastDay: today.toIso8601String(),
        currentStreak: currentStreak,
        bestStreak: bestStreak,
        mostActiveDays: mostActiveDays,
        completionRate: completionRate,
        weeklyCompletionRate: weekly,
        monthlyCompletionRate: monthly,
        yearlyCompletionRate: yearly,
        // optionally stars/achievements logic here
      );
    } catch (e) {
      log("Error calculating updated analytics: $e");
      return null;
    }
  }

  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'habits.db');

    try {
      await deleteDatabase(path);
      log("✅ Database deleted successfully");
    } catch (e) {
      log("❌ Error deleting database: $e");
    }
  }
}
