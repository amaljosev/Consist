import 'package:consist/features/diary/domain/entities/sticker_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'diary_entry_event.dart';
part 'diary_entry_state.dart';

class DiaryEntryBloc extends Bloc<DiaryEntryEvent, DiaryEntryState> {
  DiaryEntryBloc() : super( DiaryEntryState()) {
    on<TitleChanged>((event, emit) => emit(state.copyWith(title: event.title)));
    on<DescriptionChanged>((event, emit) => emit(state.copyWith(description: event.description)));
    on<MoodChanged>((event, emit) => emit(state.copyWith(mood: event.mood)));
    on<DateChanged>((event, emit) => emit(state.copyWith(date: event.date)));

    on<BgColorChanged>((event, emit) => emit(state.copyWith(bgColor: event.color, bgImage: null)));
    on<BgImageChanged>((event, emit) => emit(state.copyWith(bgImage: event.image, bgColor: null)));
    on<PhotoAdded>((event, emit) => emit(state.copyWith(photo: event.photo)));
    on<StickerAdded>((event, emit) {
  final newSticker = StickerModel(
    id: DateTime.now().toString(),
    sticker: event.sticker,
    x: 0,
    y: 0,
  );
  emit(state.copyWith(stickers: [...state.stickers, newSticker]));
});
    on<BulletInserted>((event, emit) => emit(state.copyWith(description: '${state.description}\n• ')));
    on<SaveEntry>((event, emit) {
      // Call repository to save entry here if needed
      // Example:
      // final entry = DiaryEntry(
      //   id: UniqueKey().toString(),
      //   title: state.title,
      //   content: state.description,
      //   mood: state.mood,
      //   date: DateTime.now(),
      //   preview: state.description.length > 50 ? state.description.substring(0,50) : state.description,
      //   imagePath: state.photo != null ? state.photo.toString() : null,
      //   createdAt: DateTime.now(),
      //   updatedAt: DateTime.now(),
      // );
      // repository.addEntry(entry);
    });
    on<UpdateStickerPosition>((event, emit) {
  final updatedStickers = state.stickers.map((s) {
    if (s.id == event.id) return s.copyWith(x: event.x, y: event.y);
    return s;
  }).toList();
  emit(state.copyWith(stickers: updatedStickers));
});
on<UpdateStickerSize>((event, emit) {
  final updatedStickers = state.stickers.map((s) {
    if (s.id == event.id) return s.copyWith(size: event.size);
    return s;
  }).toList();
  emit(state.copyWith(stickers: updatedStickers));
});

on<RemoveSticker>((event, emit) {
  final updatedStickers = state.stickers.where((s) => s.id != event.id).toList();
  emit(state.copyWith(stickers: updatedStickers));
});

  }
}
