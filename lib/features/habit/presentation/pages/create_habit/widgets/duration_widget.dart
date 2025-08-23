import 'package:consist/features/habit/presentation/pages/create_habit/bloc/create_bloc.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_create_tile.dart';
import 'package:consist/features/habit/presentation/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DurationWidget extends StatelessWidget {
  const DurationWidget({super.key, required this.habitEndAt});
  final String? habitEndAt;
  
  @override
  Widget build(BuildContext context) {
    return HabitCreationTile(
      icon: Icons.hourglass_bottom_sharp,
      title: 'Duration',
      trailing: habitEndAt ?? 'Off',
      onTap: () {
        String? duration;
        showModalBottomSheet(
          showDragHandle: true,
          context: context,
          builder: (BuildContext ctx) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Choose when this habit should end",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    DurationPicker(
                      onSelected: (value, cat) {
                        duration = "$value-$cat";
                      },
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      title: 'Confirm Duration',
                      onPressed: () {
                        context.read<CreateBloc>().add(
                          UpdateHabitEndAtEvent(duration ?? "1-days"),
                        );
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class DurationPicker extends StatefulWidget {
  final Function(int, String) onSelected;

  const DurationPicker({super.key, required this.onSelected});

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  final List<String> units = ['Days', 'Weeks', 'Months', 'Years'];
  int selectedNumber = 1;
  String selectedUnit = 'Days';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Number picker
        SizedBox(
          height: 200,
          width: 100,
          child: CupertinoPicker(
            itemExtent: 40,
            scrollController: FixedExtentScrollController(initialItem: 0),
            onSelectedItemChanged: (index) {
              setState(() => selectedNumber = index + 1);
              widget.onSelected(selectedNumber, selectedUnit);
            },
            children: List.generate(
              365,
              (index) => Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          height: 200,
          width: 120,
          child: CupertinoPicker(
            itemExtent: 40,
            scrollController: FixedExtentScrollController(initialItem: 0),
            onSelectedItemChanged: (index) {
              setState(() => selectedUnit = units[index]);
              widget.onSelected(selectedNumber, selectedUnit);
            },
            children: units
                .map(
                  (unit) => Center(
                    child: Text(unit, style: const TextStyle(fontSize: 18)),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}