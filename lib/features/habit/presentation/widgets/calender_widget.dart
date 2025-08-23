import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({
    super.key,
    this.isHome = false,
    this.rangeEndDay,
    this.showHeader = false,
    this.onDaySelected,
    this.onDisabled,
  });
  final bool isHome;
  final DateTime? rangeEndDay;
  final bool showHeader;
  final void Function(DateTime, DateTime)? onDaySelected;
  final void Function(DateTime)? onDisabled;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2060, 10, 16),
      calendarFormat: isHome ? CalendarFormat.week : CalendarFormat.month,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: Theme.of(
          context,
        ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
        weekendStyle: Theme.of(
          context,
        ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
      ),
      headerVisible: showHeader,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),
      headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
      onDaySelected: onDaySelected,
      onDisabledDayTapped: onDisabled,
    );
  }
}

class CalenderHomeWidget extends StatelessWidget {
  const CalenderHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2060, 10, 16),
      calendarFormat: CalendarFormat.week,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: Theme.of(
          context,
        ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
        weekendStyle: Theme.of(
          context,
        ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
      ),
      headerVisible: false,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.white24,
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),
    );
  }
}
// TableCalendar(
//       firstDay: DateTime.utc(2010, 10, 16),
//       lastDay: DateTime.utc(2060, 10, 16),
//       focusedDay: DateTime.now(),

//       calendarFormat: isHome ? CalendarFormat.week : CalendarFormat.month,
//       rangeStartDay: DateTime.now(),
//       rangeEndDay: rangeEndDay,
//       calendarStyle: CalendarStyle(
//         rangeHighlightColor: Theme.of(
//           context,
//         ).colorScheme.primary,
      
//         rangeEndDecoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.primary,
//           shape: BoxShape.circle,
//         ),
//         rangeStartDecoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.primary,
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.all(Radius.circular(12)),

//         ),
//         rangeHighlightScale: 0.3,
//         withinRangeDecoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.primary,
//           shape: BoxShape.circle,
//         ),
        
//       ),
    
//       daysOfWeekStyle: DaysOfWeekStyle(
//         weekdayStyle: TextStyle(color: Colors.white),
//         weekendStyle: TextStyle(color: Colors.white),

        
//       ),
//       headerStyle: HeaderStyle(
//         formatButtonShowsNext: false,
//         formatButtonVisible: false,
//         titleCentered: true,
//       ),
//       headerVisible: !isHome,
//     );