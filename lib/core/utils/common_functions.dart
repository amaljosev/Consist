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
    int iconId=int.parse(id);
    final iconData = HabitsItems.iconList.firstWhere(
      (item) => item["id"] == iconId,
    )["icon"] as IconData;

    return iconData;
  } catch (e) {
    return null; 
  }
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


}
