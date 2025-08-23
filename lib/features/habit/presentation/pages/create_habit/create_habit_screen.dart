import 'dart:io';
import 'package:consist/core/app_colors.dart';
import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/core/utils/common_functions.dart';
import 'package:consist/core/widgets/loading_widget.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/bloc/create_bloc.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/add_note_widget.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/bg_color_picker.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/duration_widget.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_icon.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_remainder.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_repeat.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_start_at_widget.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_time_widget.dart';
import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_type_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key, required this.type});
  final HabitType type;

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final noteController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    // Initialize with the widget type
    context.read<CreateBloc>().add(InitializeCreateEvent(widget.type));

    // Set random color and icon
    context.read<CreateBloc>().add(
      UpdateHabitColorEvent(
        AppColors.myColors[CommonFunctions.getRandomNumber(
          0,
          AppColors.myColors.length - 1,
        )],
      ),
    );
    context.read<CreateBloc>().add(
      UpdateHabitIconEvent(
        HabitsItems.habitIcons[CommonFunctions.getRandomNumber(
          0,
          HabitsItems.habitIcons.length - 1,
        )],
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    noteController.dispose();
    nameController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<CreateBloc, CreateState>(
      listener: (context, state) {
        if (state is CreateSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.of(context).pop();
        } else if (state is CreateError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is CreateValidationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${state.field}: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        if (state is CreateInitial) {
          final habit = state.habit;
          return Scaffold(
            backgroundColor: habit.habitColor,
            appBar: AppBar(
              backgroundColor: habit.habitColor,
              surfaceTintColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Platform.isAndroid ? Icons.arrow_back : CupertinoIcons.back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    
                  },
                  child: Text(
                    'Create',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 20,
                    children: [
                      HabitIcon(isDark: isDark, icon: habit.habitIcon!),
                      TextFormField(
                        controller: nameController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration.collapsed(
                          hintText: 'New Habit',
                          hintStyle: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.w800,
                                color: Colors.black38,
                              ),
                        ),
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(color: Colors.black),
                        maxLength: 40,
                        maxLines: null,
                        cursorWidth: 4,
                        onChanged: (val) {
                          context.read<CreateBloc>().add(
                            UpdateHabitNameEvent(val),
                          );
                        },
                      ),
                      HabitColor(bgClr: habit.habitColor),

                      Card(
                        color: isDark ? Colors.black26 : null,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              HabitTypeWidget(
                                habitType: habit.habitType ?? widget.type.name,
                                isDark: isDark,
                              ),
                              Divider(
                                height: 0,
                                color: isDark ? null : Colors.black12,
                              ),

                              HabitStartAtWidget(
                                habitStartAt: habit.habitStartAt,
                                isDark: isDark,
                              ),
                              Divider(
                                height: 0,
                                color: isDark ? null : Colors.black12,
                              ),

                              HabitTimeWidget(habitTime: habit.habitTime),
                              Divider(
                                height: 0,
                                color: isDark ? null : Colors.black12,
                              ),

                              if (habit.habitType != 'task')
                                HabitRepeatWidget(
                                  habitRepeat: habit.habitRepeatValue,

                                  bgColor: habit.habitColor,
                                ),
                              Divider(
                                height: 0,
                                color: isDark ? null : Colors.black12,
                              ),
                              DurationWidget(habitEndAt: habit.habitEndAt),
                              Divider(
                                height: 0,
                                color: isDark ? null : Colors.black12,
                              ),

                              HabitRemainderWidget(time: habit.habitRemindTime),
                            ],
                          ),
                        ),
                      ),

                      AddNoteWidget(
                        isDark: isDark,
                        noteController: noteController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is CreateLoading) {
          return const AppLoading();
        } else {
          return const AppLoading();
        }
      },
    );
  }
}
