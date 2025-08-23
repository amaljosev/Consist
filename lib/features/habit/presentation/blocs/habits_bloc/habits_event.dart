part of 'habits_bloc.dart';

abstract class HabitsEvent {}

class InitialEvent extends HabitsEvent {}

class BottomNavScreenChangeEvent extends HabitsEvent {
  final int index;

  BottomNavScreenChangeEvent({required this.index});
}
