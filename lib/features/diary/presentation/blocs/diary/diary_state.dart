part of 'diary_bloc.dart';


class DiaryState extends Equatable {
  final List<DiaryEntry> entries;
  final double scrollOffset;
  final Color dominantColor;

  // New fields:
  final bool isLoading;
  final String? errorMessage;

  const DiaryState({
    this.entries = const [],
    this.scrollOffset = 0.0,
    this.dominantColor = Colors.grey,
    this.isLoading = false,
    this.errorMessage,
  });

  DiaryState copyWith({
    List<DiaryEntry>? entries,
    double? scrollOffset,
    Color? dominantColor,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DiaryState(
      entries: entries ?? this.entries,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      dominantColor: dominantColor ?? this.dominantColor,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [entries, scrollOffset, dominantColor, isLoading, errorMessage];
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

