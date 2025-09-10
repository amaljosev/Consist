class DiaryEntry {
  final String id;
  final String title;
  final String date;
  final String preview;
  final String mood;
  final String content;
  final String? imagePath;
  final String? bgColor;
  final String? bgImagePath;
  final String? stickersJson;
  final String? imagesJson;
  final String createdAt;
  final String updatedAt;

  const DiaryEntry({
    required this.id,
    required this.title,
    required this.date,
    required this.preview,
    required this.mood,
    required this.content,
    this.imagePath,
    this.bgColor,
    this.bgImagePath,
    this.stickersJson,
    this.imagesJson,
    required this.createdAt,
    required this.updatedAt,
  });
}
