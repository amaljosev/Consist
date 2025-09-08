
import 'package:consist/features/diary/domain/entities/diary_entry_model.dart';

class DiaryEntryModel extends DiaryEntry {
  const DiaryEntryModel({
    required super.id,
    required super.title,
    required super.date,
    required super.preview,
    required super.mood,
    required super.content,
    super.imagePath,
    required super.createdAt,
    required super.updatedAt,
  });

  factory DiaryEntryModel.fromMap(Map<String, dynamic> map) {
    return DiaryEntryModel(
      id: map['id'] as String,
      title: map['title'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      preview: map['preview'] as String,
      mood: map['mood'] as String,
      content: map['content'] as String,
      imagePath: map['image_path'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'preview': preview,
      'mood': mood,
      'content': content,
      'image_path': imagePath,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory DiaryEntryModel.fromEntity(DiaryEntry entry) {
    return DiaryEntryModel(
      id: entry.id,
      title: entry.title,
      date: entry.date,
      preview: entry.preview,
      mood: entry.mood,
      content: entry.content,
      imagePath: entry.imagePath,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
    );
  }

  DiaryEntry toEntity() {
    return DiaryEntry(
      id: id,
      title: title,
      date: date,
      preview: preview,
      mood: mood,
      content: content,
      imagePath: imagePath,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
