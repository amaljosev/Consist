part of 'diary_bloc.dart';

class DiaryState extends Equatable {
  final List<DiaryEntry> entries;
  final Color dominantColor;
  final double scrollOffset;

  const DiaryState({
    this.entries = const [],
    this.dominantColor = Colors.grey,
    this.scrollOffset = 0.0,
  });

  DiaryState copyWith({
    List<DiaryEntry>? entries,
    Color? dominantColor,
    double? scrollOffset,
  }) {
    return DiaryState(
      entries: entries ?? this.entries,
      dominantColor: dominantColor ?? this.dominantColor,
      scrollOffset: scrollOffset ?? this.scrollOffset,
    );
  }

  @override
  List<Object?> get props => [entries, dominantColor, scrollOffset];
}

class DiaryEntryState extends Equatable {
  final String title;
  final String description;
  final String mood;
  final Color? bgColor;
  final ImageProvider? bgImage;
  final ImageProvider? photo;
  final List<String> stickers;

  const DiaryEntryState({
    this.title = '',
    this.description = '',
    this.mood = '🙂',
    this.bgColor,
    this.bgImage,
    this.photo,
    this.stickers = const [],
  });

  DiaryEntryState copyWith({
    String? title,
    String? description,
    String? mood,
    Color? bgColor,
    ImageProvider? bgImage,
    ImageProvider? photo,
    List<String>? stickers,
  }) {
    return DiaryEntryState(
      title: title ?? this.title,
      description: description ?? this.description,
      mood: mood ?? this.mood,
      bgColor: bgColor ?? this.bgColor,
      bgImage: bgImage ?? this.bgImage,
      photo: photo ?? this.photo,
      stickers: stickers ?? this.stickers,
    );
  }

  @override
  List<Object?> get props => [title, description, mood, bgColor, bgImage, photo, stickers];
}