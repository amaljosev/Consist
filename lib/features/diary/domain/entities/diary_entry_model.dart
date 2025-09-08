class DiaryEntry {
  final String id;
  final String title;
  final DateTime date;
  final String preview;
  final String mood;
  final String content;
  final String? imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DiaryEntry({
    required this.id,
    required this.title,
    required this.date,
    required this.preview,
    required this.mood,
    required this.content,
    this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });
}
