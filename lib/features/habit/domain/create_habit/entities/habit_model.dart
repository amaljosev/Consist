class Habit {
  final String id;
  final String? habitName;
  final String? note;
  final String? habitIconId;
  final String? habitType;
  final String? habitStartAt;
  final String? habitTime;
  final String? habitEndAt;
  final String? habitRepeatValue;
  final String? repeatDays;
  final String? habitRemindTime;
  final String? habitColorId;

  Habit({
    required this.id,
    this.habitName,
    this.note,
    this.habitIconId,
    this.habitType,
    this.habitStartAt,
    this.habitTime,
    this.habitEndAt,
    this.habitRepeatValue,
    this.repeatDays,
    this.habitRemindTime,
    this.habitColorId,
  });

  Habit copyWith({
    String? id,
    String? habitName,
    String? note,
    String? habitIconId,
    String? habitType,
    String? habitStartAt,
    String? habitTime,
    String? habitEndAt,
    String? habitRepeatValue,
    String? habitRemindTime,
    String? habitColorId,
    String? repeatDays,
  }) {
    return Habit(
      id: id ?? this.id,
      habitName: habitName ?? this.habitName,
      note: note ?? this.note,
      habitIconId: habitIconId ?? this.habitIconId,
      habitType: habitType ?? this.habitType,
      habitStartAt: habitStartAt ?? this.habitStartAt,
      habitTime: habitTime ?? this.habitTime,
      habitEndAt: habitEndAt ?? this.habitEndAt,
      habitRemindTime: habitRemindTime ?? this.habitRemindTime,
      habitColorId: habitColorId ?? this.habitColorId,
      habitRepeatValue: habitRepeatValue ?? this.habitRepeatValue,
      repeatDays: repeatDays ?? this.repeatDays,
    );
  }

  // Convert Habit → Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'habitName': habitName,
      'note': note,
      'habitIconId': habitIconId,
      'habitType': habitType,
      'habitStartAt': habitStartAt,
      'habitTime': habitTime,
      'habitEndAt': habitEndAt,
      'habitRepeatValue': habitRepeatValue,
      'repeatDays': repeatDays,
      'habitRemindTime': habitRemindTime,
      'habitColorId': habitColorId,
    };
  }

  // Convert Map → Habit
  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      habitName: map['habitName'],
      note: map['note'],
      habitIconId: map['habitIconId'],
      habitType: map['habitType'],
      habitStartAt: map['habitStartAt'],
      habitTime: map['habitTime'],
      habitEndAt: map['habitEndAt'],
      habitRepeatValue: map['habitRepeatValue'],
      repeatDays: map['repeatDays'],
      habitRemindTime: map['habitRemindTime'],
      habitColorId: map['habitColorId'],
    );
  }
}
