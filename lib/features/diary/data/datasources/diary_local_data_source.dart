import 'package:consist/core/database/diary_db.dart';
import 'package:sqflite/sqflite.dart';
import '../models/diary_entry_model.dart';

class DiaryLocalDataSource {
  final DiaryDatabase _dbProvider = DiaryDatabase.instance;
  static const table = 'diary_entries';

  Future<void> insertEntry(DiaryEntryModel entry) async {
    final db = await _dbProvider.database;
    await db.insert(table, entry.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<DiaryEntryModel>> getAllEntries() async {
    final db = await _dbProvider.database;
    final maps = await db.query(table, orderBy: 'created_at DESC');
    return maps.map((m) => DiaryEntryModel.fromMap(m)).toList();
  }

  Future<DiaryEntryModel?> getEntryById(String id) async {
    final db = await _dbProvider.database;
    final maps = await db.query(table, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return DiaryEntryModel.fromMap(maps.first);
  }

  Future<int> updateEntry(DiaryEntryModel entry) async {
    final db = await _dbProvider.database;
    return db.update(table, entry.toMap(), where: 'id = ?', whereArgs: [entry.id]);
  }

  Future<int> deleteEntry(String id) async {
    final db = await _dbProvider.database;
    return db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DiaryEntryModel>> search(String query) async {
    final db = await _dbProvider.database;
    final maps = await db.query(
      table,
      where: 'title LIKE ? OR content LIKE ? OR preview LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );
    return maps.map((m) => DiaryEntryModel.fromMap(m)).toList();
  }
}
