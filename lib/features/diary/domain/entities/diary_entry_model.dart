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
  final List<String>? stickers;

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
    this.stickers,
    required this.createdAt,
    required this.updatedAt,
  });
}
