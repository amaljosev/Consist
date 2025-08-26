import 'package:consist/features/habit/data/datasources/habit_local_datasource.dart';
import 'package:consist/features/habit/domain/create_habit/entities/habit_model.dart';
import 'package:consist/features/habit/domain/create_habit/repositories/habit_repository.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitDatabase db;

  HabitRepositoryImpl({required this.db});

  @override
  Future<int> createHabit(Habit habit) async {
    return await db.createHabit(habit);
  }

  @override
  Future<List<Habit>> getAllHabits() async {
    return await db.getAllHabits();
  }

  @override
  Future<Habit?> getHabitById(String id) async {
    return await db.getHabitById(id);
  }

  @override
  Future<int> updateHabit(Habit habit) async {
    return await db.updateHabit(habit);
  }

  @override
  Future<int> deleteHabit(String id) async {
    return await db.deleteHabit(id);
  }
}