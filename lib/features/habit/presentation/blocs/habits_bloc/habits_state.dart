part of 'habits_bloc.dart';

abstract class HabitsState extends Equatable {
  const HabitsState();

  @override
  List<Object?> get props => [];
}

class HabitsInitial extends HabitsState {}

class HabitsLoading extends HabitsState {}

class HabitsLoaded extends HabitsState {
  final List<Habit> habits;
  const HabitsLoaded({required this.habits});

  @override
  List<Object?> get props => [habits];
}

class HabitsError extends HabitsState {
  final String message;
  const HabitsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class BottomNavScreenChangeState extends HabitsState {
  final int index;
  const BottomNavScreenChangeState({required this.index});

  @override
  List<Object?> get props => [index];
}
