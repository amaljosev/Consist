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

  @override
  List<Object?> get props => [id, sticker, x, y, size];
}
