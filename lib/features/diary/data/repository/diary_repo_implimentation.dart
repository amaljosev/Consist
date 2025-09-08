import 'package:consist/features/diary/data/datasources/diary_local_data_source.dart';
import 'package:consist/features/diary/data/models/diary_entry_model.dart';
import 'package:consist/features/diary/domain/entities/diary_entry_model.dart';
import 'package:consist/features/diary/domain/repository/diary_repository.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryLocalDataSource local;

  DiaryRepositoryImpl(this.local);

  @override
  Future<void> addEntry(DiaryEntry entry) async {
    final model = DiaryEntryModel.fromEntity(entry);
    await local.insertEntry(model);
  }

  @override
  Future<void> deleteEntry(String id) async {
    await local.deleteEntry(id);
  }

  @override
  Future<List<DiaryEntry>> getAllEntries() async {
    final models = await local.getAllEntries();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<DiaryEntry?> getEntryById(String id) async {
    final model = await local.getEntryById(id);
    return model?.toEntity();
  }

  @override
  Future<void> updateEntry(DiaryEntry entry) async {
    final model = DiaryEntryModel.fromEntity(entry);
    await local.updateEntry(model);
  }

  @override
  Future<List<DiaryEntry>> searchEntries(String query) async {
    final models = await local.search(query);
    return models.map((m) => m.toEntity()).toList();
  }
}