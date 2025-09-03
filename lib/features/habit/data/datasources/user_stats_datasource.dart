import 'package:consist/features/habit/domain/create_habit/entities/user_stats.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserStatsDatabase {
  static final UserStatsDatabase instance = UserStatsDatabase._init();
  static Database? _database;

  UserStatsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user_stats.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableUserStats (
      ${UserStatsFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${UserStatsFields.commonStreak} INTEGER NOT NULL DEFAULT 0,
      ${UserStatsFields.bestStreak} INTEGER NOT NULL DEFAULT 0,
      ${UserStatsFields.lastLoginDate} TEXT,
      ${UserStatsFields.completionRate} REAL NOT NULL DEFAULT 0.0,
      ${UserStatsFields.weeklyProgress} TEXT,
      ${UserStatsFields.monthlyProgress} TEXT,
      ${UserStatsFields.yearlyProgress} TEXT,
      ${UserStatsFields.mostActiveDays} TEXT,
      ${UserStatsFields.stars} INTEGER NOT NULL DEFAULT 0,
      ${UserStatsFields.totalHabitsCompleted} INTEGER NOT NULL DEFAULT 0,
      ${UserStatsFields.longestHabit} TEXT,
      ${UserStatsFields.averageDailyHabits} REAL NOT NULL DEFAULT 0.0,
      ${UserStatsFields.createdAt} TEXT,
      ${UserStatsFields.updatedAt} TEXT
    )
    ''');
  }

  // CREATE
  Future<UserStatsModel> create(UserStatsModel stats) async {
    final db = await instance.database;
    final id = await db.insert(tableUserStats, stats.toJson());
    return stats.copyWith(id: id);
  }

  // READ
  Future<UserStatsModel?> readUserStats(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableUserStats,
      columns: UserStatsFields.values,
      where: '${UserStatsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserStatsModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  // UPDATE
  Future<int> update(UserStatsModel stats) async {
    final db = await instance.database;
    return db.update(
      tableUserStats,
      stats.toJson(),
      where: '${UserStatsFields.id} = ?',
      whereArgs: [stats.id],
    );
  }

  // DELETE
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableUserStats,
      where: '${UserStatsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
