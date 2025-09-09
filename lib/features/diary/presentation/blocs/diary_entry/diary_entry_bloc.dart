import 'package:consist/features/diary/data/datasources/diary_local_data_source.dart';
import 'package:consist/features/diary/data/models/diary_entry_model.dart';
import 'package:consist/features/diary/data/repository/diary_repo_implementation.dart';
import 'package:consist/features/diary/domain/entities/sticker_model.dart';
import 'package:consist/features/diary/domain/repository/diary_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'diary_entry_event.dart';
part 'diary_entry_state.dart';

class DiaryEntryBloc extends Bloc<DiaryEntryEvent, DiaryEntryState> {
  DiaryEntryBloc() : super(DiaryEntryState()) {
    on<TitleChanged>((event, emit) => emit(state.copyWith(title: event.title)));
    on<DescriptionChanged>(
      (event, emit) => emit(state.copyWith(description: event.description)),
    );
    on<MoodChanged>((event, emit) => emit(state.copyWith(mood: event.mood)));
    on<DateChanged>((event, emit) => emit(state.copyWith(date: event.date)));
    on<BgColorChanged>(
      (event, emit) => emit(state.copyWith(bgColor: event.color, bgImage: '')),
    );
    on<BgImageChanged>(
      (event, emit) =>
          emit(state.copyWith(bgImage: event.image, bgColor: null)),
    );
    on<StickerAdded>((event, emit) {
      final newSticker = StickerModel(
        id: DateTime.now().toString(),
        sticker: event.sticker,
        x: 0,
        y: 0,
      );
      emit(state.copyWith(stickers: [...state.stickers, newSticker]));
    });
    on<BulletInserted>(
      (event, emit) =>
          emit(state.copyWith(description: '${state.description}\n• ')),
    );
    on<SaveEntry>(_onSaveEntry);
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
      final updatedStickers = state.stickers
          .where((s) => s.id != event.id)
          .toList();
      emit(state.copyWith(stickers: updatedStickers));
    });

    // New image events
    on<ImageAdded>((event, emit) {
      final newImage = DiaryImage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imagePath: event.imagePath,
        x: 0,
        y: 0,
        width: 100,
        height: 100,
        scale: 1.0,
      );
      emit(state.copyWith(images: [...state.images, newImage]));
    });
    on<UpdateImagePosition>((event, emit) {
      final updatedImages = state.images.map((image) {
        if (image.id == event.imageId) {
          return image.copyWith(x: event.x, y: event.y);
        }
        return image;
      }).toList();
      emit(state.copyWith(images: updatedImages));
    });
    on<UpdateImageSize>((event, emit) {
      final updatedImages = state.images.map((image) {
        if (image.id == event.imageId) {
          return image.copyWith(scale: event.scale);
        }
        return image;
      }).toList();
      emit(state.copyWith(images: updatedImages));
    });
    on<RemoveImage>((event, emit) {
      final updatedImages = state.images
          .where((image) => image.id != event.imageId)
          .toList();
      emit(state.copyWith(images: updatedImages));
    });
  }
  Future<void> _onSaveEntry(
    SaveEntry event,
    Emitter<DiaryEntryState> emit,
  ) async {
     final diaryLocalDataSource = DiaryLocalDataSource();
  final DiaryRepository diaryRepository = DiaryRepositoryImpl(
    diaryLocalDataSource,
  );
    final now = DateTime.now();

    final entry = DiaryEntryModel(
      id: now.microsecondsSinceEpoch.toString(),
      title: state.title,
      date: state.date.toIso8601String(),
      preview: state.description.length > 50
          ? state.description.substring(0, 50)
          : state.description,
      mood: state.mood,
      content: state.description,
      imagePath: null,
      bgColor: state.bgColor?.value .toString(),
      bgImagePath: state.bgImage,
      stickers: state.stickers.map((s) => s.sticker).toList(),
      createdAt: now.toIso8601String(),
      updatedAt: now.toIso8601String(),
    );
    await diaryRepository.addEntry(entry);
  }
}
