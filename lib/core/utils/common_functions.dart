import 'dart:math';

import 'package:consist/core/app_colors.dart';
import 'package:consist/core/constants/habits_items.dart';
import 'package:flutter/material.dart';

class CommonFunctions {
  static int getRandomNumber(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  TimeOfDay parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }

  static IconData? getIconById(String id) {
    try {
      final iconData =
          HabitsItems.habitList.firstWhere(
                (item) => item["id"] == id,
              )["icon"]
              as IconData;

      return iconData;
    } catch (e) {
      return null;
    }
  }

  static String? getCategoryNameById(String? id) {
    if (id == null) return null;
    final category = HabitsItems.habitCategories.firstWhere(
      (cat) => cat["id"] == id,
      orElse: () => {"id": id, "name": "Off"},
    );
    return category["name"]!;
  }

  static Color? getColorById(String id) {
    final allColors = [...AppColors.myColors, ...AppColors.myColorsDarker];
    final match = allColors.firstWhere(
      (map) => map['id'] == id,
      orElse: () => {},
    );
    return match['color'] as Color?;
  }

  static Color darken(Color color, [double amount = .3]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  static bool isNewDayForHabit(String? lastCompletionDateStr) {
    if (lastCompletionDateStr == null) return true;
    final parts = lastCompletionDateStr.split(':');
    if (parts.length != 3) return true;

    final lastDay = int.tryParse(parts[0]) ?? 0;
    final lastMonth = int.tryParse(parts[1]) ?? 0;
    final lastYear = int.tryParse(parts[2]) ?? 0;

    final today = DateTime.now();

    return !(lastDay == today.day &&
        lastMonth == today.month &&
        lastYear == today.year);
  }
}
