part of 'create_bloc.dart';

@immutable
abstract class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object?> get props => [];
}

class InitializeCreateEvent extends CreateEvent {
  final HabitType type;

  const InitializeCreateEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class UpdateHabitNameEvent extends CreateEvent {
  final String habitName;

  const UpdateHabitNameEvent(this.habitName);

  @override
  List<Object?> get props => [habitName];
}

class UpdateHabitNoteEvent extends CreateEvent {
  final String note;

  const UpdateHabitNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class UpdateHabitIconEvent extends CreateEvent {
  final IconData icon;

  const UpdateHabitIconEvent(this.icon);

  @override
  List<Object?> get props => [icon];
}

class UpdateHabitTypeEvent extends CreateEvent {
  final String type;

  const UpdateHabitTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class UpdateHabitColorEvent extends CreateEvent {
  final Color color;

  const UpdateHabitColorEvent(this.color);

  @override
  List<Object?> get props => [color];
}

class UpdateHabitStartAtEvent extends CreateEvent {
  final DateTime startAt;

  const UpdateHabitStartAtEvent(this.startAt);

  @override
  List<Object?> get props => [startAt];
}

class UpdateHabitTimeEvent extends CreateEvent {
  final String time;

  const UpdateHabitTimeEvent(this.time);

  @override
  List<Object?> get props => [time];
}

class UpdateHabitEndAtEvent extends CreateEvent {
  final String endAt;

  const UpdateHabitEndAtEvent(this.endAt);

  @override
  List<Object?> get props => [endAt];
}

class UpdateHabitRepeatValueEvent extends CreateEvent {
  final String repeatValue;

  const UpdateHabitRepeatValueEvent(this.repeatValue);

  @override
  List<Object?> get props => [repeatValue];
}

class UpdateRepeatDaysEvent extends CreateEvent {
  final int repeatDays;

  const UpdateRepeatDaysEvent(this.repeatDays);

  @override
  List<Object?> get props => [repeatDays];
}

class UpdateWeekDaysEvent extends CreateEvent {
  final List<int> weekDays;

  const UpdateWeekDaysEvent(this.weekDays);

  @override
  List<Object?> get props => [weekDays];
}

class UpdateMonthDaysEvent extends CreateEvent {
  final List<int> monthDays;

  const UpdateMonthDaysEvent(this.monthDays);

  @override
  List<Object?> get props => [monthDays];
}

class UpdateHabitRemindTimeEvent extends CreateEvent {
  final String remindTime;

  const UpdateHabitRemindTimeEvent(this.remindTime);

  @override
  List<Object?> get props => [remindTime];
}

class SaveHabitEvent extends CreateEvent {}

class ResetCreateEvent extends CreateEvent {}