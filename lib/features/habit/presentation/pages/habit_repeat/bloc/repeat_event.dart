part of 'repeat_bloc.dart';

abstract class RepeatEvent {}

class ToggleRepeatEvent extends RepeatEvent {
  final bool enabled;
  ToggleRepeatEvent(this.enabled);
}

class ChangeTabEvent extends RepeatEvent {
  final int tabIndex;
  ChangeTabEvent(this.tabIndex);
}

class UpdateIntervalEvent extends RepeatEvent {
  final int interval;
  UpdateIntervalEvent(this.interval);
}

class SelectWeekdayEvent extends RepeatEvent {
  final int weekday;
  SelectWeekdayEvent(this.weekday);
}

class SelectMonthDayEvent extends RepeatEvent {
  final int day;
  SelectMonthDayEvent(this.day);
}
