import 'dart:convert';
import 'dart:io';
import 'package:consist/features/diary/data/models/diary_entry_model.dart';
import 'package:consist/features/diary/domain/entities/sticker_model.dart';
import 'package:consist/features/diary/presentation/blocs/diary/diary_bloc.dart';
import 'package:consist/features/diary/presentation/blocs/diary_entry/diary_entry_bloc.dart';
import 'package:consist/features/diary/presentation/pages/entry/diary_entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

class DiaryPreviewScreen extends StatelessWidget {
  final String entryId;

  const DiaryPreviewScreen({super.key, required this.entryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<DiaryBloc>()..add(FetchEntryById(entryId)),
      child: const DiaryEntryPreviewForm(),
    );
  }
}

class DiaryEntryPreviewForm extends StatefulWidget {
  const DiaryEntryPreviewForm({super.key});

  @override
  State<DiaryEntryPreviewForm> createState() => _DiaryEntryPreviewFormState();
}

class _DiaryEntryPreviewFormState extends State<DiaryEntryPreviewForm> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _descriptionKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DiaryBloc, DiaryState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(
                "Error: ${state.errorMessage}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state.entries.isEmpty) {
            return const Center(child: Text("Diary entry not found"));
          }

          final entry = state.entries.first;
          return _buildBackground(context, entry);
        },
      ),
    );
  }

  Widget _buildBackground(BuildContext context, DiaryEntryModel entry) {
    final bgColor = _parseColorFromString(entry.bgColor) ?? Colors.white;
    final bgImage = entry.bgImagePath ?? '';

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        image: bgImage.isNotEmpty
            ? DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover)
            : null,
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Container(color: Colors.white54),
            _buildContent(context, entry),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DiaryEntryModel entry) {
    return Column(
      children: [
        AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<DiaryBloc>().add(LoadDiaryEntries());
            },
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : CupertinoIcons.back,
            ),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          forceMaterialTransparency: true,
          automaticallyImplyLeading: true,
          elevation: 0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(child: _buildHeaderSection(context, entry)),
                SliverToBoxAdapter(
                  child: _buildDescriptionSection(context, entry),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
          ),
        ),
        _buildBottomSection(context, entry),
      ],
    );
  }

  Widget _buildHeaderSection(BuildContext context, DiaryEntryModel entry) {
    final date = entry.date.isNotEmpty
        ? DateTime.tryParse(entry.date) ?? DateTime.now()
        : DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDateDisplay(context, date),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildMoodSelector(context, entry.mood),
            const SizedBox(width: 12),
            Expanded(child: _buildTitleField(context, entry.title)),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDateDisplay(BuildContext context, DateTime date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                intl.DateFormat('EEEE').format(date).toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: intl.DateFormat('dd').format(date),
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    TextSpan(
                      text: intl.DateFormat(' MMM').format(date),
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                    ),
                    TextSpan(
                      text: intl.DateFormat(' yyyy').format(date),
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.calendar_today_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSelector(BuildContext context, String mood) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(child: Text(mood, style: const TextStyle(fontSize: 28))),
    );
  }

  Widget _buildTitleField(BuildContext context, String? title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        (title == null || title.isEmpty) ? "Untitled Entry" : title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDescriptionSection(BuildContext context, DiaryEntryModel entry) {
    List<StickerModel> stickers = [];
    List<DiaryImage> images = [];

    try {
      stickers = (entry.stickersJson != null)
          ? (List<Map<String, dynamic>>.from(
              jsonDecode(entry.stickersJson ?? '[]'),
            )).map((m) => StickerModel.fromJson(m)).toList()
          : [];
    } catch (_) {}

    try {
      images = (entry.imagesJson != null)
          ? (List<Map<String, dynamic>>.from(
              jsonDecode(entry.imagesJson ?? '[]'),
            )).map((m) => DiaryImage.fromJson(m)).toList()
          : [];
    } catch (_) {}

    return Container(
      key: _descriptionKey,
      constraints: const BoxConstraints(minHeight: 200),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SelectableText(
              entry.content.isEmpty ? "What's on your mind?" : entry.content,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ...stickers.map(
            (sticker) => Positioned(
              left: sticker.x,
              top: sticker.y,
              child: Text(
                sticker.sticker,
                style: TextStyle(fontSize: sticker.size),
              ),
            ),
          ),
          ...images.map(
            (image) => Positioned(
              left: image.x,
              top: image.y,
              child: Transform.scale(
                scale: image.scale,
                child: _buildImageWidget(image),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(DiaryImage image) {
    try {
      if (image.imagePath.isEmpty) return const SizedBox();
      final file = File(image.imagePath);
      if (!file.existsSync()) return const SizedBox();

      return Image.file(
        file,
        width: image.width,
        height: image.height,
        fit: BoxFit.cover,
      );
    } catch (_) {
      return const SizedBox();
    }
  }

  Widget _buildBottomSection(BuildContext context, DiaryEntryModel entry) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              final String? result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DiaryEntryScreen(entry: entry),
                ),
              );
              if (result !=null && context.mounted) {
                context.read<DiaryBloc>().add(FetchEntryById(result));
              }
            },
            icon: const Icon(Icons.edit),
            label: const Text("Edit"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              context.read<DiaryBloc>().add(DeleteDiaryEntry(entry.id));
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.delete),
            label: const Text("Delete"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          ),
        ],
      ),
    );
  }

  Color? _parseColorFromString(String? input) {
    if (input == null) return null;
    final s = input.trim();

    if (s.startsWith('Color(') && s.contains('red:')) {
      try {
        final redMatch = RegExp(r'red:\s*([0-9.]+)').firstMatch(s);
        final greenMatch = RegExp(r'green:\s*([0-9.]+)').firstMatch(s);
        final blueMatch = RegExp(r'blue:\s*([0-9.]+)').firstMatch(s);
        final alphaMatch = RegExp(r'alpha:\s*([0-9.]+)').firstMatch(s);
        final r = double.parse(redMatch?.group(1) ?? '1.0');
        final g = double.parse(greenMatch?.group(1) ?? '1.0');
        final b = double.parse(blueMatch?.group(1) ?? '1.0');
        final a = double.parse(alphaMatch?.group(1) ?? '1.0');
        return Color.fromRGBO(
          (r * 255).round(),
          (g * 255).round(),
          (b * 255).round(),
          a,
        );
      } catch (_) {
        return null;
      }
    }

    try {
      var hex = s;
      if (hex.startsWith('#')) hex = hex.substring(1);
      if (hex.startsWith('0x')) hex = hex.substring(2);
      if (hex.length == 6) hex = 'FF$hex';
      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return null;
    }
  }
}
