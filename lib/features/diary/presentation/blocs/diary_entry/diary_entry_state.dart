part of 'diary_entry_bloc.dart';

class DiaryEntryState extends Equatable {
  final String title;
  final String description;
  final String mood;
  final Color? bgColor;
  final String bgImage;
  final List<StickerModel> stickers;
  final List<DiaryImage> images;
  final DateTime date;

  DiaryEntryState({
    this.title = '',
    this.description = '',
    this.mood = '🙂',
    this.bgColor,
    this.bgImage = '',
    this.stickers = const [],
    this.images = const [],
    DateTime? date,
  }) : date = date ?? DateTime.now();

  DiaryEntryState copyWith({
    String? title,
    String? description,
    String? mood,
    Color? bgColor,
    String? bgImage,
    List<StickerModel>? stickers,
    List<DiaryImage>? images,
    DateTime? date,
  }) {
    return DiaryEntryState(
      title: title ?? this.title,
      description: description ?? this.description,
      mood: mood ?? this.mood,
      bgColor: bgColor ?? this.bgColor,
      bgImage: bgImage ?? this.bgImage,
      stickers: stickers ?? this.stickers,
      images: images ?? this.images,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [
    title,
    description,
    mood,
    bgColor,
    bgImage,
    stickers,
    images,
    date,
  ];
}

// DiaryImage model (add this to your existing sticker_model.dart or create new file)
class DiaryImage extends Equatable {
  final String id;
  final String imagePath;
  final double x;
  final double y;
  final double width;
  final double height;
  final double scale;

  const DiaryImage({
    required this.id,
    required this.imagePath,
    this.x = 0,
    this.y = 0,
    this.width = 100,
    this.height = 100,
    this.scale = 1.0,
  });

  DiaryImage copyWith({
    String? id,
    String? imagePath,
    double? x,
    double? y,
    double? width,
    double? height,
    double? scale,
  }) {
    return DiaryImage(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      scale: scale ?? this.scale,
    );
  }

  @override
  List<Object?> get props => [id, imagePath, x, y, width, height, scale];
}