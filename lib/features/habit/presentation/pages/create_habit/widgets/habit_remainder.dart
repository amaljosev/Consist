import 'package:consist/features/habit/presentation/pages/create_habit/bloc/create_bloc.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_create_tile.dart';
import 'package:consist/features/habit/presentation/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HabitRemainderWidget extends StatelessWidget {
  const HabitRemainderWidget({super.key, required this.time});
  final String? time;

  @override
  Widget build(BuildContext context) {
    return HabitCreationTile(
      icon: Icons.notifications_active_outlined,
      title: 'Remainder',
      trailing: time ?? 'Off',
      onTap: () => showModalBottomSheet(
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          DateTime pickedDateTime = DateTime.now();

          return StatefulBuilder(
            builder: (context, setState) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Pick a time to remind you",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),

                      /// Cupertino Time Picker
                      SizedBox(
                        height: 200,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          use24hFormat: false, 
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (DateTime newTime) {
                            setState(() {
                              pickedDateTime = newTime;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      AppButton(
                        title: 'Submit Time',
                        onPressed: () {
                          // Format picked time as hh:mm a
                          final formattedTime = DateFormat(
                            "hh:mm a",
                          ).format(pickedDateTime);

                          context.read<CreateBloc>().add(
                            UpdateHabitRemindTimeEvent(formattedTime),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
