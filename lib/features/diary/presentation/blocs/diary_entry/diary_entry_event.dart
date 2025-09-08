part of 'diary_entry_bloc.dart';

abstract class DiaryEntryEvent extends Equatable {
  const DiaryEntryEvent();

  @override
  List<Object?> get props => [];
}

// Field changes
class TitleChanged extends DiaryEntryEvent {
  final String title;
  const TitleChanged(this.title);

  @override
  List<Object?> get props => [title];
}

class DescriptionChanged extends DiaryEntryEvent {
  final String description;
  const DescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class MoodChanged extends DiaryEntryEvent {
  final String mood;
  const MoodChanged(this.mood);

  @override
  List<Object?> get props => [mood];
}

class BgColorChanged extends DiaryEntryEvent {
  final Color color;
  const BgColorChanged(this.color);

  @override
  List<Object?> get props => [color];
}

class BgImageChanged extends DiaryEntryEvent {
  final ImageProvider image;
  const BgImageChanged(this.image);

  @override
  List<Object?> get props => [image];
}

class PhotoAdded extends DiaryEntryEvent {
  final ImageProvider photo;
  const PhotoAdded(this.photo);

  @override
  List<Object?> get props => [photo];
}

class StickerAdded extends DiaryEntryEvent {
  final String sticker;
  const StickerAdded(this.sticker);

  @override
  List<Object?> get props => [sticker];
}

class BulletInserted extends DiaryEntryEvent {}

class SaveEntry extends DiaryEntryEvent {}
class DateChanged extends DiaryEntryEvent {
  final DateTime date;
  const DateChanged(this.date);

  @override
  List<Object?> get props => [date];
}

class UpdateStickerPosition extends DiaryEntryEvent {
  final String id;
  final double x;
  final double y;
  const UpdateStickerPosition(this.id, this.x, this.y);

  @override
  List<Object?> get props => [id, x, y];
}
class UpdateStickerSize extends DiaryEntryEvent {
  final String id;
  final double size;
  const UpdateStickerSize(this.id, this.size);

  @override
  List<Object?> get props => [id, size];
}

class RemoveSticker extends DiaryEntryEvent {
  final String id;
  const RemoveSticker(this.id);

  @override
  List<Object?> get props => [id];
}
