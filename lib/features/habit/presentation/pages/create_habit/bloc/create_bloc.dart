import 'dart:async';
import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/features/habit/domain/create_habit/entities/habit_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(CreateInitial(habit: _createInitialHabit())) {
    on<InitializeCreateEvent>(_onInitialize);
    on<UpdateHabitNameEvent>(_onUpdateHabitName);
    on<UpdateHabitNoteEvent>(_onUpdateHabitNote);
    on<UpdateHabitIconEvent>(_onUpdateHabitIcon);
    on<UpdateHabitTypeEvent>(_onUpdateHabitType);
    on<UpdateHabitColorEvent>(_onUpdateHabitColor);
    on<UpdateHabitStartAtEvent>(_onUpdateHabitStartAt);
    on<UpdateHabitTimeEvent>(_onUpdateHabitTime);
    on<UpdateHabitEndAtEvent>(_onUpdateHabitEndAt);
    on<UpdateHabitRepeatValueEvent>(_onUpdateHabitRepeatValue);
    on<UpdateRepeatDaysEvent>(_onUpdateRepeatDays);
    on<UpdateWeekDaysEvent>(_onUpdateWeekDays);
    on<UpdateMonthDaysEvent>(_onUpdateMonthDays);
    on<UpdateHabitRemindTimeEvent>(_onUpdateHabitRemindTime);
    on<SaveHabitEvent>(_onSaveHabit);
    on<ResetCreateEvent>(_onReset);
  }

  static Habit _createInitialHabit() {
    return Habit(
      id:  DateTime.now().toString(),
      habitName: null,
      note: null,
      habitIcon: Icons.rocket_launch_outlined,
      habitType: null,
      habitStartAt: null,
      habitTime: null,
      habitEndAt: null,
      habitRepeatValue: null,
      repeatDays: null,
      habitRemindTime: null,
      habitColor: Colors.blue,
    );
  }

  Future<void> _onInitialize(
    InitializeCreateEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(
          habitType: event.type.name,
        ),
      ));
    }
  }

  Future<void> _onUpdateHabitName(
    UpdateHabitNameEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(habitName: event.habitName),
      ));
    }
  }

  Future<void> _onUpdateHabitNote(
    UpdateHabitNoteEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(note: event.note),
      ));
    }
  }

  Future<void> _onUpdateHabitIcon(
    UpdateHabitIconEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(habitIcon: event.icon),
      ));
    }
  }

  Future<void> _onUpdateHabitType(
    UpdateHabitTypeEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(habitType: event.type),
      ));
    }
  }

  Future<void> _onUpdateHabitColor(
    UpdateHabitColorEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(habitColor: event.color),
      ));
    }
  }

  Future<void> _onUpdateHabitStartAt(
    UpdateHabitStartAtEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(habitStartAt: event.startAt),
      ));
    }
  }

  Future<void> _onUpdateHabitTime(
    UpdateHabitTimeEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(habitTime: event.time),
      ));
    }
  }

  Future<void> _onUpdateHabitEndAt(
    UpdateHabitEndAtEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(habitEndAt: event.endAt),
      ));
    }
  }

  Future<void> _onUpdateHabitRepeatValue(
    UpdateHabitRepeatValueEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(habitRepeatValue: event.repeatValue),
      ));
    }
  }

  Future<void> _onUpdateRepeatDays(
    UpdateRepeatDaysEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(repeatDays: event.repeatDays),
      ));
    }
  }

  Future<void> _onUpdateWeekDays(
    UpdateWeekDaysEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(weekDays: event.weekDays),
      ));
    }
  }

  Future<void> _onUpdateMonthDays(
    UpdateMonthDaysEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(monthDays: event.monthDays),
      ));
    }
  }

  Future<void> _onUpdateHabitRemindTime(
    UpdateHabitRemindTimeEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      emit(CreateInitial(
        habit: currentState.habit.copyWith(habitRemindTime: event.remindTime),
      ));
    }
  }

  Future<void> _onSaveHabit(
    SaveHabitEvent event,
    Emitter<CreateState> emit,
  ) async {
    final currentState = state;
    if (currentState is CreateInitial) {
      final habit = currentState.habit;

      // Validation
      if (habit.habitName == null || habit.habitName!.isEmpty) {
        emit(CreateValidationError('habitName', 'Habit name is required'));
        return;
      }

      if (habit.habitIcon == null) {
        emit(CreateValidationError('habitIcon', 'Please select an icon'));
        return;
      }

      if (habit.habitType == null) {
        emit(CreateValidationError('habitType', 'Please select a habit type'));
        return;
      }

      emit(CreateLoading());

      try {
        // Here you would save to database/local storage
        await Future.delayed(const Duration(milliseconds: 500)); // Simulate save

        // Emit success and reset
        emit(CreateSuccess('Habit created successfully'));
        
        // Reset to initial state after success
        add(ResetCreateEvent());
      } catch (e) {
        emit(CreateError('Failed to save habit: $e'));
      }
    }
  }

  Future<void> _onReset(
    ResetCreateEvent event,
    Emitter<CreateState> emit,
  ) async {
    emit(CreateInitial(habit: _createInitialHabit()));
  }
}