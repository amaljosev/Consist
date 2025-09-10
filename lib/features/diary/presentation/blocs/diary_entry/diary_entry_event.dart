part of 'diary_entry_bloc.dart';

abstract class DiaryEntryEvent extends Equatable {
  const DiaryEntryEvent();

  @override
  List<Object?> get props => [];
}
class InitializeDiaryEntry extends DiaryEntryEvent {
  final DiaryEntryModel? entry;
  const InitializeDiaryEntry(this.entry);

  @override
  List<Object?> get props => [entry];
}

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
  final String image;
  const BgImageChanged(this.image);

  @override
  List<Object?> get props => [image];
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

// New image events
class ImageAdded extends DiaryEntryEvent {
  final String imagePath;
  const ImageAdded(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class UpdateImagePosition extends DiaryEntryEvent {
  final String imageId;
  final double x;
  final double y;
  const UpdateImagePosition(this.imageId, this.x, this.y);

  @override
  List<Object?> get props => [imageId, x, y];
}

class UpdateImageSize extends DiaryEntryEvent {
  final String imageId;
  final double scale;
  const UpdateImageSize(this.imageId, this.scale);

  @override
  List<Object?> get props => [imageId, scale];
}

class RemoveImage extends DiaryEntryEvent {
  final String imageId;
  const RemoveImage(this.imageId);

  @override
  List<Object?> get props => [imageId];
}

class SelectSticker extends DiaryEntryEvent {
  final String id;
  const SelectSticker(this.id);

  @override
  List<Object?> get props => [id];
}

class SelectImage extends DiaryEntryEvent {
  final String id;
  const SelectImage(this.id);

  @override
  List<Object?> get props => [id];
}

class DeselectAll extends DiaryEntryEvent {}