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

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE habits (
        id TEXT PRIMARY KEY,
        habitName TEXT,
        note TEXT,
        habitIconId TEXT,
        habitType TEXT,
        habitStartAt TEXT,
        habitTime TEXT,
        habitEndAt TEXT,
        habitRepeatValue TEXT,
        repeatDays TEXT,
        habitRemindTime TEXT,
        habitColorId TEXT
      )
    ''');
  }

  // ✅ Create
  Future<int> createHabit(Habit habit) async {
    final db = await instance.database;
    return await db.insert('habits', {
      'id': habit.id,
      'habitName': habit.habitName,
      'note': habit.note,
      'habitIconId': habit.habitIconId,
      'habitType': habit.habitType,
      'habitStartAt': habit.habitStartAt,
      'habitTime': habit.habitTime,
      'habitEndAt': habit.habitEndAt,
      'habitRepeatValue': habit.habitRepeatValue,
      'repeatDays': habit.repeatDays,
      'habitRemindTime': habit.habitRemindTime,
      'habitColorId': habit.habitColorId,
    });
  }

  // ✅ Read all
  Future<List<Habit>> getAllHabits() async {
    final db = await instance.database;
    final result = await db.query('habits');
    return result.map((map) => Habit(
      id: map['id'] as String,
      habitName: map['habitName'] as String?,
      note: map['note'] as String?,
      habitIconId: map['habitIconId'] as String?,
      habitType: map['habitType'] as String?,
      habitStartAt: map['habitStartAt'] as String?,
      habitTime: map['habitTime'] as String?,
      habitEndAt: map['habitEndAt'] as String?,
      habitRepeatValue: map['habitRepeatValue'] as String?,
      repeatDays: map['repeatDays'] as String?,
      habitRemindTime: map['habitRemindTime'] as String?,
      habitColorId: map['habitColorId'] as String?,
    )).toList();
  }

  // ✅ Read one by ID
  Future<Habit?> getHabitById(String id) async {
    final db = await instance.database;
    final result = await db.query('habits', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      final map = result.first;
      return Habit(
        id: map['id'] as String,
        habitName: map['habitName'] as String?,
        note: map['note'] as String?,
        habitIconId: map['habitIconId'] as String?,
        habitType: map['habitType'] as String?,
        habitStartAt: map['habitStartAt'] as String?,
        habitTime: map['habitTime'] as String?,
        habitEndAt: map['habitEndAt'] as String?,
        habitRepeatValue: map['habitRepeatValue'] as String?,
        repeatDays: map['repeatDays'] as String?,
        habitRemindTime: map['habitRemindTime'] as String?,
        habitColorId: map['habitColorId'] as String?,
      );
    }
    return null;
  }

  // ✅ Update
  Future<int> updateHabit(Habit habit) async {
    final db = await instance.database;
    return await db.update(
      'habits',
      {
        'habitName': habit.habitName,
        'note': habit.note,
        'habitIconId': habit.habitIconId,
        'habitType': habit.habitType,
        'habitStartAt': habit.habitStartAt,
        'habitTime': habit.habitTime,
        'habitEndAt': habit.habitEndAt,
        'habitRepeatValue': habit.habitRepeatValue,
        'repeatDays': habit.repeatDays,
        'habitRemindTime': habit.habitRemindTime,
        'habitColorId': habit.habitColorId,
      },
      where: 'id = ?',
      whereArgs: [habit.id],
    );
  }

  // ✅ Delete
  Future<int> deleteHabit(String id) async {
    final db = await instance.database;
    return await db.delete('habits', where: 'id = ?', whereArgs: [id]);
  }

  // ✅ Close DB
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
