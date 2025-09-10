import 'package:consist/features/diary/data/models/diary_entry_model.dart';
import 'package:consist/features/diary/presentation/blocs/diary/diary_bloc.dart';
import 'package:consist/features/diary/presentation/pages/entry/diary_entry.dart';
import 'package:consist/features/diary/presentation/widgets/entry_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Diary"),
        centerTitle: true,
      ),
      body: BlocBuilder<DiaryBloc, DiaryState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text("Error: ${state.errorMessage}"));
          }

          if (state.entries.isEmpty) {
            return const Center(child: Text("No diary entries yet"));
          }

          return ListView.builder(
            itemCount: state.entries.length,
            itemBuilder: (context, index) {
              final DiaryEntryModel entry = state.entries[index];
              return DiaryEntryCard(entry: entry);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
              // navigate to add-entry screen, then refresh
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const DiaryEntryScreen(entry: null),
                ),
              );
              if (result == true&&context.mounted) {
                // Reload entries after adding new one
                context.read<DiaryBloc>().add(LoadDiaryEntries());
              }
            },
        child: const Icon(Icons.add),
      ),
    );
  }
}
