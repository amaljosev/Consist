part of 'diary_entry_bloc.dart';


class DiaryEntryState extends Equatable {
  final String title;
  final String description;
  final String mood;
  final Color? bgColor;
  final ImageProvider? bgImage;
  final ImageProvider? photo;
  final List<StickerModel> stickers; 
  final DateTime date;

   DiaryEntryState({
    this.title = '',
    this.description = '',
    this.mood = '🙂',
    this.bgColor,
    this.bgImage,
    this.photo,
    this.stickers = const [],
    DateTime? date,
  }) : date = date ?? DateTime.now();

  DiaryEntryState copyWith({
    String? title,
    String? description,
    String? mood,
    Color? bgColor,
    ImageProvider? bgImage,
    ImageProvider? photo,
    List<StickerModel>? stickers,
    DateTime? date,
  }) {
    return DiaryEntryState(
      title: title ?? this.title,
      description: description ?? this.description,
      mood: mood ?? this.mood,
      bgColor: bgColor ?? this.bgColor,
      bgImage: bgImage ?? this.bgImage,
      photo: photo ?? this.photo,
      stickers: stickers ?? this.stickers,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [title, description, mood, bgColor, bgImage, photo, stickers, date];
}
