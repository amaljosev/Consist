class HabitCompletion {
  final int? id;
  final String habitId;
  final String completionDate; 
  final bool isCompleted;

  HabitCompletion({
    this.id,
    required this.habitId,
    required this.completionDate,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'habitId': habitId,
    'completionDate': completionDate,
    'isCompleted': isCompleted ? 1 : 0,
  };

  factory HabitCompletion.fromMap(Map<String, dynamic> map) => HabitCompletion(
    id: map['id'],
    habitId: map['habitId'],
    completionDate: map['completionDate'],
    isCompleted: map['isCompleted'] == 1,
  );
}
