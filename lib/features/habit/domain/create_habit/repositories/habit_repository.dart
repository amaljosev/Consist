import 'package:consist/features/habit/domain/create_habit/entities/habit_model.dart';

abstract class HabitRepository {
  Future<int> createHabit(Habit habit);
  Future<List<Habit>> getAllHabits();
  Future<Habit?> getHabitById(String id);
  Future<int> updateHabit(Habit habit);
  Future<int> deleteHabit(String id);
}