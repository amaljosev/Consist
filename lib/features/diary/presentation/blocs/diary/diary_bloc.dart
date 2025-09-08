import 'dart:typed_data';

import 'package:consist/features/diary/domain/entities/diary_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image/image.dart' as img;

part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  DiaryBloc() : super(const DiaryState()) {
    on<LoadDiaryEntries>(_onLoadEntries);
    on<UpdateScrollOffset>(_onUpdateScrollOffset);
    on<UpdateDominantColor>(_onUpdateDominantColor);
    
  }

  Future<void> _onLoadEntries(
      LoadDiaryEntries event, Emitter<DiaryState> emit) async {
    // Here you can load from database or API
    emit(state.copyWith(entries: [
      // Add your hardcoded entries or fetch from DB
    ]));
  }

  void _onUpdateScrollOffset(
      UpdateScrollOffset event, Emitter<DiaryState> emit) {
    emit(state.copyWith(scrollOffset: event.offset));
  }

  Future<void> _onUpdateDominantColor(
      UpdateDominantColor event, Emitter<DiaryState> emit) async {
    try {
      final ByteData data = await rootBundle.load(event.imagePath);
      final Uint8List bytes = Uint8List.fromList(data.buffer.asUint8List());
      final image = img.decodeImage(bytes);
      if (image == null) return;

      final int sampleHeight = (image.height * 0.1).round();
      final int startY = image.height - sampleHeight;

      Map<Color, int> colorCounts = {};

      for (int y = startY; y < image.height; y += 5) {
        for (int x = 0; x < image.width; x += 5) {
          final pixel = image.getPixel(x, y);
          final color = Color.fromARGB(
            pixel.a.toInt(),
            pixel.r.toInt(),
            pixel.g.toInt(),
            pixel.b.toInt(),
          );
          final groupedColor = _groupSimilarColor(color);
          colorCounts[groupedColor] = (colorCounts[groupedColor] ?? 0) + 1;
        }
      }

      if (colorCounts.isNotEmpty) {
        final mostFrequentColor =
            colorCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
        emit(state.copyWith(dominantColor: mostFrequentColor));
      }
    } catch (e) {
      emit(state.copyWith(dominantColor: Colors.grey[900]!));
    }
  }

  Color _groupSimilarColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    final groupedHue = (hsl.hue / 30).round() * 30.0;
    return HSLColor.fromAHSL(hsl.alpha, groupedHue, hsl.saturation, hsl.lightness)
        .toColor();
  }
}