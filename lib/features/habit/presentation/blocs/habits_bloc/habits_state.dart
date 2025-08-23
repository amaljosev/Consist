part of 'habits_bloc.dart';

abstract class HabitsState {}

final class HabitsInitial extends HabitsState {}

 class BottomNavScreenChangeState extends HabitsState {
  final int index;

  BottomNavScreenChangeState({required this.index});
}
