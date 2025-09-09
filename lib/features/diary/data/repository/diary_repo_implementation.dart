import 'dart:developer';
import 'package:consist/features/diary/data/datasources/diary_local_data_source.dart';
import 'package:consist/features/diary/data/models/diary_entry_model.dart';
import 'package:consist/features/diary/domain/entities/diary_entry_model.dart';
import 'package:consist/features/diary/domain/repository/diary_repository.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryLocalDataSource localDataSource;

  DiaryRepositoryImpl(this.localDataSource);

  @override
  Future<void> addEntry(DiaryEntry entry) async {
    try {
      final model = DiaryEntryModel.fromEntity(entry);
      await localDataSource.insertEntry(model);
    } catch (e, st) {
      log('addEntry error: $e', stackTrace: st);
      rethrow; // or handle gracefully
    }
  }

  @override
  Future<void> updateEntry(DiaryEntry entry) async {
    try {
      final model = DiaryEntryModel.fromEntity(entry);
      await localDataSource.updateEntry(model);
    } catch (e, st) {
      log('updateEntry error: $e', stackTrace: st);
      rethrow; // or handle gracefully
    }
  }

  @override
  Future<void> deleteEntry(String id) async {
    try {
      await localDataSource.deleteEntry(id);
    } catch (e, st) {
      log('deleteEntry error: $e', stackTrace: st);
      rethrow; // or handle gracefully
    }
  }

  @override
  Future<List<DiaryEntry>> getAllEntries() async {
    try {
      final models = await localDataSource.getAllEntries();
      return models.map((m) => m.toEntity()).toList();
    } catch (e, st) {
      log('getAllEntries error: $e', stackTrace: st);
      return []; // safe fallback
    }
  }

  @override
  Future<DiaryEntry?> getEntryById(String id) async {
    try {
      final model = await localDataSource.getEntryById(id);
      return model?.toEntity();
    } catch (e, st) {
      log('getEntryById error: $e', stackTrace: st);
      return null; // safe fallback
    }
  }

  @override
  Future<List<DiaryEntry>> searchEntries(String query) async {
    try {
      final models = await localDataSource.search(query);
      return models.map((m) => m.toEntity()).toList();
    } catch (e, st) {
      log('searchEntries error: $e', stackTrace: st);
      return []; // safe fallback
    }
  }
}
