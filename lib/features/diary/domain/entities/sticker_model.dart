import 'package:equatable/equatable.dart';

class StickerModel extends Equatable {
  final String id;
  final String sticker;
  final double x;
  final double y;
  final double size; // <-- new

  const StickerModel({
    required this.id,
    required this.sticker,
    required this.x,
    required this.y,
    this.size = 28, // default size
  });

  StickerModel copyWith({
    String? id,
    String? sticker,
    double? x,
    double? y,
    double? size,
  }) {
    return StickerModel(
      id: id ?? this.id,
      sticker: sticker ?? this.sticker,
      x: x ?? this.x,
      y: y ?? this.y,
      size: size ?? this.size,
    );
  }
 Map<String, dynamic> toJson() => {
        'id': id,
        'sticker': sticker,
        'x': x,
        'y': y,
        'size': size,
      };

  factory StickerModel.fromJson(Map<String, dynamic> json) {
    return StickerModel(
      id: json['id'],
      sticker: json['sticker'],
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      size: (json['size'] as num).toDouble(),
    );
  }
  @override
  List<Object?> get props => [id, sticker, x, y, size];
}
