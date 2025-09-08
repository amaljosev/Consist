part of 'diary_bloc.dart';

abstract class DiaryEvent extends Equatable {
  const DiaryEvent();

  @override
  List<Object?> get props => [];
}

class LoadDiaryEntries extends DiaryEvent {}

class UpdateScrollOffset extends DiaryEvent {
  final double offset;
  const UpdateScrollOffset(this.offset);

  @override
  List<Object?> get props => [offset];
}

class UpdateDominantColor extends DiaryEvent {
  final String imagePath;
  const UpdateDominantColor(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

