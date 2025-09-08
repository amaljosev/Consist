import 'dart:ui';
import 'package:consist/features/diary/presentation/blocs/diary/diary_bloc.dart';
import 'package:consist/features/diary/presentation/pages/entry/diary_entry.dart';
import 'package:consist/features/diary/presentation/widgets/entry_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final ScrollController _scrollController = ScrollController();

  final String currentImagePath = 'assets/img/diary.png';
  @override
  void initState() {
    context.read<DiaryBloc>().add(UpdateDominantColor(currentImagePath));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiaryBloc, DiaryState>(
      builder: (context, state) {
        final bloc = context.read<DiaryBloc>();

        _scrollController.addListener(() {
          bloc.add(UpdateScrollOffset(_scrollController.offset));
        });

        double blurIntensity = (state.scrollOffset / 100).clamp(0.0, 10.0);
        double opacity = (1 - state.scrollOffset / 300).clamp(0.0, 1.0);
        double titleOpacity = (1 - state.scrollOffset / 150).clamp(0.0, 1.0);

        Color textColor =
            ThemeData.estimateBrightnessForColor(state.dominantColor) ==
                Brightness.dark
            ? Colors.white
            : Colors.black;

        return Scaffold(
          backgroundColor: state.dominantColor,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 200.0,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  title: Opacity(opacity: titleOpacity),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(currentImagePath, fit: BoxFit.cover),
                      if (blurIntensity > 0)
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: blurIntensity,
                              sigmaY: blurIntensity,
                            ),
                            child: Container(color: Colors.transparent),
                          ),
                        ),
                      Opacity(
                        opacity: opacity,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                state.dominantColor.withOpacity(0.8),
                                state.dominantColor.withOpacity(0.4),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Opacity(
                                opacity: titleOpacity,
                                child: Text(
                                  'My Diary',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Opacity(
                                opacity: titleOpacity,
                                child: Text(
                                  '${state.entries.length} entries',
                                  style: TextStyle(
                                    color: textColor.withOpacity(0.8),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final entry = state.entries[index];
                  return DiaryEntryCard(
                    entry: entry,
                    backgroundColor: state.dominantColor.withOpacity(0.1),
                  );
                }, childCount: state.entries.length),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => DiaryEntryScreen())),
            backgroundColor: state.dominantColor,
            child: Icon(Icons.add, color: textColor),
          ),
        );
      },
    );
  }
}
