
import 'package:consist/features/diary/domain/entities/diary_entry_model.dart';

abstract class DiaryRepository {
  Future<List<DiaryEntry>> getAllEntries();
  Future<DiaryEntry?> getEntryById(String id);
  Future<void> addEntry(DiaryEntry entry);
  Future<void> updateEntry(DiaryEntry entry);
  Future<void> deleteEntry(String id);
  Future<List<DiaryEntry>> searchEntries(String query);
}
