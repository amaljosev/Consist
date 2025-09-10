part of 'diary_bloc.dart';

class DiaryState extends Equatable {
  final List<DiaryEntryModel> entries; 
  final bool isLoading;
  final String? errorMessage;
  final double scrollOffset;
  final Color? dominantColor;

  const DiaryState({
    this.entries = const [],
    this.isLoading = false,
    this.errorMessage,
    this.scrollOffset = 0.0,
    this.dominantColor,
  });

  DiaryState copyWith({
    List<DiaryEntryModel>? entries,
    bool? isLoading,
    String? errorMessage,
    double? scrollOffset,
    Color? dominantColor,
  }) {
    return DiaryState(
      entries: entries ?? this.entries,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      dominantColor: dominantColor ?? this.dominantColor,
    );
  }

  @override
  List<Object?> get props =>
      [entries, isLoading, errorMessage, scrollOffset, dominantColor];
}
