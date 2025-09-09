import 'dart:convert';
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
    super.bgColor,
    super.bgImagePath,
    super.stickers,
    required super.createdAt,
    required super.updatedAt,
  });

  factory DiaryEntryModel.fromMap(Map<String, dynamic> map) {
    return DiaryEntryModel(
      id: map['id'] as String,
      title: map['title'] as String,
      date: map['date'] as String? ?? '',
      preview: map['preview'] as String,
      mood: map['mood'] as String,
      content: map['content'] as String,
      imagePath: map['image_path'] as String?,
      bgColor: map['bg_color'] as String?,
      bgImagePath: map['bg_image_path'] as String?,
      stickers: map['stickers'] != null
          ? List<String>.from(jsonDecode(map['stickers']))
          : null,
      createdAt: map['created_at'] as String? ?? '',
      updatedAt: map['updated_at'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date, // String
      'preview': preview,
      'mood': mood,
      'content': content,
      'image_path': imagePath,
      'bg_color': bgColor,
      'bg_image_path': bgImagePath,
      'stickers': stickers != null ? jsonEncode(stickers) : null,
      'created_at': createdAt, // String
      'updated_at': updatedAt, // String
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
      bgColor: entry.bgColor,
      bgImagePath: entry.bgImagePath,
      stickers: entry.stickers,
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
      bgColor: bgColor,
      bgImagePath: bgImagePath,
      stickers: stickers,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
