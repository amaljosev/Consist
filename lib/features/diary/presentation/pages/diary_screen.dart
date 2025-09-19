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
      body: BlocBuilder<DiaryBloc, DiaryState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // Custom Sliver App Bar with image
              SliverAppBar(
                expandedHeight: 200.0,
                stretch: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.blurBackground],
                  background: Image.asset(
                    'assets/img/diary.png',
                    fit: BoxFit.cover,
                  ),
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(
                    bottom: 16,
                  ), // move closer to bottom
                  title: const Text(
                    "My Diary",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 6,
                          color: Colors.black45,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                floating: false,
                pinned: false,
                snap: false,
              ),

              // Header with month/year
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Row(
                    children: [
                      Text(
                        "Recent Entries",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Spacer(),
                      Text(
                        "${DateTime.now().month}/${DateTime.now().year}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Show appropriate state
              if (state.isLoading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                )
              else if (state.errorMessage != null)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Error: ${state.errorMessage}",
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<DiaryBloc>().add(LoadDiaryEntries());
                            },
                            child: const Text("Try Again"),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else if (state.entries.isEmpty)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                            ),
                            child: Image.asset('assets/img/no_entries.png'),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            "No entries yet",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Start writing your thoughts...",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                // Entries list
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final DiaryEntryModel entry = state.entries[index];
                    return DiaryEntryCard(entry: entry);
                  }, childCount: state.entries.length),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const DiaryEntryScreen(entry: null),
            ),
          );
          if (result == true && context.mounted) {
            context.read<DiaryBloc>().add(LoadDiaryEntries());
          }
        },

        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
