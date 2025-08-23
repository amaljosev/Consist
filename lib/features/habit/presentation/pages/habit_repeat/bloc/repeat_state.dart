part of 'repeat_bloc.dart';


class RepeatState {
  final bool repeatEnabled;
  final int selectedTab;
  final int intervalNumber;
  final Set<int> selectedWeekdays;
  final Set<int> selectedDaysOfMonth;

  const RepeatState({
    this.repeatEnabled = true,
    this.selectedTab = 0,
    this.intervalNumber = 1,
    this.selectedWeekdays = const {},
    this.selectedDaysOfMonth = const {},
  });

  RepeatState copyWith({
    bool? repeatEnabled,
    int? selectedTab,
    int? intervalNumber,
    Set<int>? selectedWeekdays,
    Set<int>? selectedDaysOfMonth,
  }) {
    return RepeatState(
      repeatEnabled: repeatEnabled ?? this.repeatEnabled,
      selectedTab: selectedTab ?? this.selectedTab,
      intervalNumber: intervalNumber ?? this.intervalNumber,
      selectedWeekdays: selectedWeekdays ?? this.selectedWeekdays,
      selectedDaysOfMonth: selectedDaysOfMonth ?? this.selectedDaysOfMonth,
    );
  }
}
