import 'package:flutter_bloc/flutter_bloc.dart';

part 'repeat_event.dart';
part 'repeat_state.dart';

class RepeatBloc extends Bloc<RepeatEvent, RepeatState> {
  RepeatBloc() : super(const RepeatState()) {
    on<ToggleRepeatEvent>((event, emit) {
      emit(state.copyWith(repeatEnabled: event.enabled));
    });

    on<ChangeTabEvent>((event, emit) {
      if (event.tabIndex == 0) {
        emit(state.copyWith(selectedTab: 0, intervalNumber: 1));
      } else if (event.tabIndex == 1) {
        emit(state.copyWith(selectedTab: 1, selectedWeekdays: {}));
      } else if (event.tabIndex == 2) {
        emit(state.copyWith(selectedTab: 2, selectedDaysOfMonth: {}));
      }
    });

    on<UpdateIntervalEvent>((event, emit) {
      emit(state.copyWith(intervalNumber: event.interval));
    });

    on<SelectWeekdayEvent>((event, emit) {
      final newWeekdays = Set<int>.from(state.selectedWeekdays);
      if (newWeekdays.contains(event.weekday)) {
        newWeekdays.remove(event.weekday);
      } else {
        newWeekdays.add(event.weekday);
      }
      emit(state.copyWith(selectedWeekdays: newWeekdays));
    });

    on<SelectMonthDayEvent>((event, emit) {
      final newDays = Set<int>.from(state.selectedDaysOfMonth);
      if (newDays.contains(event.day)) {
        newDays.remove(event.day);
      } else {
        newDays.add(event.day);
      }
      emit(state.copyWith(selectedDaysOfMonth: newDays));
    });
  }
}