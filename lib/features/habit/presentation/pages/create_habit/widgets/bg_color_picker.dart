import 'package:consist/core/app_colors.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/bloc/create_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitColor extends StatelessWidget {
  const HabitColor({super.key, required this.bgClr});
  final Color? bgClr;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: List.generate(AppColors.myColors.length, (index) {
        final colorData = AppColors.myColors[index];
        final color=colorData['color'];
        return GestureDetector(
          onTap: () =>
              context.read<CreateBloc>().add(UpdateHabitColorEvent(colorData['id'].toString())),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundColor: color,
              child: bgClr == color
                  ? Icon(Icons.check, color: Colors.black)
                  : null,
            ),
          ),
        );
      }),
    );
  }
}
