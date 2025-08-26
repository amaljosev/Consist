import 'dart:io';
import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/core/utils/common_functions.dart';
import 'package:consist/core/utils/converters.dart';
import 'package:consist/core/widgets/loading_widget.dart';
import 'package:consist/features/habit/domain/create_habit/entities/habit_model.dart';
import 'package:consist/features/habit/presentation/blocs/habits_bloc/habits_bloc.dart';
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
  const CreateScreen({super.key, required this.type, required this.habit});
  final HabitType type;
  final Habit? habit;

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final noteController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<CreateBloc>().add(
      InitializeCreateEvent(widget.type, widget.habit),
    );
    if (widget.habit != null) {
      nameController.text = widget.habit!.habitName ?? '';
      noteController.text = widget.habit!.note ?? '';
    }
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
            backgroundColor: CommonFunctions.getColorById(habit.habitColorId!),
            appBar: AppBar(
              backgroundColor: CommonFunctions.getColorById(
                habit.habitColorId!,
              ),
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
                  onPressed: () => _formKey.currentState!.validate()
                      ? _createHabit(context, habit, widget.habit != null)
                      : null,
                  child: Text(
                    widget.habit != null ? 'Update' : 'Create',
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 20,
                      children: [
                        HabitIcon(isDark: isDark, icon: habit.habitIconId),
                        TextFormField(
                          controller: nameController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration.collapsed(
                            hintText: 'New Habit',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headlineMedium!
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

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a habit name';
                            }
                            return null;
                          },
                        ),
                        HabitColor(
                          bgClr: CommonFunctions.getColorById(
                            habit.habitColorId!,
                          ),
                        ),

                        Card(
                          color: isDark ? Colors.black26 : null,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                HabitTypeWidget(
                                  habitType:
                                      habit.habitType ?? widget.type.name,
                                  isDark: isDark,
                                ),
                                Divider(
                                  height: 0,
                                  color: isDark ? null : Colors.black12,
                                ),

                                HabitStartAtWidget(
                                  habitStartAt: AppConverters.stringToDateTime(
                                    habit.habitStartAt,
                                  ),
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

                                    bgColor: AppConverters.stringToColor(
                                      habit.habitColorId,
                                    ),
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

                                HabitRemainderWidget(
                                  time: habit.habitRemindTime,
                                ),
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

  void _createHabit(BuildContext context, Habit habit, bool isUpdate) {
    final newHabit = Habit(
      id: isUpdate ? habit.id : DateTime.now().toString(),
      habitName: nameController.text,
      habitColorId: habit.habitColorId,
      habitEndAt: habit.habitEndAt ?? 'Off',
      habitIconId: habit.habitIconId,
      habitRemindTime: habit.habitRemindTime ?? 'Off',
      habitRepeatValue: habit.habitRepeatValue ?? 'Daily',
      habitStartAt: habit.habitStartAt ?? 'Today',
      habitTime: habit.habitTime ?? 'Anytime',
      habitType: habit.habitType,
      note: noteController.text,
      repeatDays: habit.repeatDays,
    );
    if (isUpdate) {
      context.read<HabitsBloc>().add(UpdateHabitEvent(newHabit));
    } else {
      context.read<HabitsBloc>().add(AddHabitEvent(newHabit));
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
