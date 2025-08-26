import 'package:consist/features/habit/presentation/pages/create_habit/widgets/habit_create_tile.dart';
import 'package:flutter/material.dart';

class AddNoteWidget extends StatelessWidget {
  const AddNoteWidget({
    super.key,
    required this.isDark,
    required this.noteController,
  });

  final bool isDark;
  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDark ? Colors.black26 : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: HabitCreationTile(
          icon: Icons.book_outlined,
          title: 'Add Note',
          trailing: null,
          onTap: () => showNoteDialog(context, noteController),
        ),
      ),
    );
  }
}

Future<void> showNoteDialog(
  BuildContext context,
  TextEditingController noteController,
) async {
  final formKey = GlobalKey<FormState>();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Add Note',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: noteController,
            maxLength: 100,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Note',

              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a note';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              noteController.text='';
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                debugPrint('Note: ${noteController.text}');
                Navigator.pop(context);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );
}
