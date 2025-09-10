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
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.scale,
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'imagePath': imagePath,
        'x': x,
        'y': y,
        'width': width,
        'height': height,
        'scale': scale,
      };

  factory DiaryImage.fromJson(Map<String, dynamic> json) {
    return DiaryImage(
      id: json['id'],
      imagePath: json['imagePath'],
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      scale: (json['scale'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [id, imagePath, x, y, width, height, scale];
}
