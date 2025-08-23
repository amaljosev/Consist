import 'package:flutter/material.dart';

class Habit {
  final String id;
  final String? habitName;

  final String? note;

  final IconData? habitIcon;

  final String? habitType;

  final DateTime? habitStartAt;

  final String? habitTime;

  final String? habitEndAt;

  final String? habitRepeatValue;

  final Object? repeatDays;

  final String? habitRemindTime;

  final Color? habitColor;

  Habit({
    required this.id,
    this.habitName,
    this.note,
    this.habitIcon,
    this.habitType,
    this.habitStartAt,
    this.habitTime,
    this.habitEndAt,
    this.habitRepeatValue,
    this.repeatDays,

    this.habitRemindTime,
    this.habitColor,
  });

  Habit copyWith({
    String? id,
    String? habitName,
    String? note,
    IconData? habitIcon,
    String? habitType,
    DateTime? habitStartAt,
    String? habitTime,
    String? habitEndAt,
    String? habitRepeatValue,
    String? habitRemindTime,
    Color? habitColor,
    int? repeatDays,
    List? weekDays,
    List? monthDays,
  }) {
    return Habit(
      id: id ?? this.id,
      habitName: habitName ?? this.habitName,
      note: note ?? this.note,
      habitIcon: habitIcon ?? this.habitIcon,
      habitType: habitType ?? this.habitType,
      habitStartAt: habitStartAt ?? this.habitStartAt,
      habitTime: habitTime ?? this.habitTime,
      habitEndAt: habitEndAt ?? this.habitEndAt,
      habitRemindTime: habitRemindTime ?? this.habitRemindTime,
      habitColor: habitColor ?? this.habitColor,
      habitRepeatValue: habitRepeatValue ?? this.habitRepeatValue,
      repeatDays: repeatDays ?? this.repeatDays,
    );
  }
}
