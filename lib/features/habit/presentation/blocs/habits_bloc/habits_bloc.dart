
import 'package:consist/features/habit/domain/create_habit/entities/habit_model.dart';
import 'package:consist/features/habit/domain/create_habit/repositories/habit_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  final HabitRepository habitRepository;

  HabitsBloc({required this.habitRepository}) : super(HabitsInitial()) {
    // Load all habits
    on<LoadHabitsEvent>((event, emit) async {
      emit(HabitsLoading());
      try {
        final habits = await habitRepository.getAllHabits();
        emit(HabitsLoaded(habits: habits));
      } catch (e) {
        emit(HabitsError(message: e.toString()));
      }
    });

    // Add new habit
    on<AddHabitEvent>((event, emit) async {
      try {
        await habitRepository.createHabit(event.habit);
        final habits = await habitRepository.getAllHabits();
        emit(HabitsLoaded(habits: habits));
      } catch (e) {
        emit(HabitsError(message: e.toString()));
      }
    });

    // Update habit
    on<UpdateHabitEvent>((event, emit) async {
      try {
        emit(HabitsLoading());
       await habitRepository.updateHabit(event.habit);
        final habits = await habitRepository.getAllHabits();
        emit(HabitsLoaded(habits: habits));
      } catch (e) {
        emit(HabitsError(message: e.toString()));
      }
    });

    // Delete habit
    on<DeleteHabitEvent>((event, emit) async {
      try {
        await habitRepository.deleteHabit(event.id);
        final habits = await habitRepository.getAllHabits();
        emit(HabitsLoaded(habits: habits));
      } catch (e) {
        emit(HabitsError(message: e.toString()));
      }
    });

    // Bottom nav change (your existing one)
    on<BottomNavScreenChangeEvent>(
      (event, emit) => emit(BottomNavScreenChangeState(index: event.index)),
    );
  }
}