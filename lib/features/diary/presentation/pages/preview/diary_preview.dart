import 'dart:convert';
import 'dart:io';
import 'package:consist/core/utils/converters.dart';
import 'package:consist/features/diary/data/models/diary_entry_model.dart';
import 'package:consist/features/diary/domain/entities/sticker_model.dart';
import 'package:consist/features/diary/presentation/blocs/diary_entry/diary_entry_bloc.dart';
import 'package:consist/features/diary/presentation/pages/entry/diary_entry.dart';
import 'package:flutter/material.dart';

class DiaryPreviewScreen extends StatelessWidget {
  final DiaryEntryModel entry;

  const DiaryPreviewScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    // Decode stickers safely
    List<StickerModel> stickers = [];
    if (entry.stickersJson != null && entry.stickersJson is String) {
      try {
        final decoded = jsonDecode(entry.stickersJson as String);
        if (decoded is List) {
          stickers = decoded
              .map((e) => StickerModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      } catch (e) {
        debugPrint("Sticker decode error: $e");
      }
    }

    // Decode images safely
    List<DiaryImage> images = [];
    if (entry.imagesJson != null && entry.imagesJson is String) {
      try {
        final decoded = jsonDecode(entry.imagesJson as String);
        if (decoded is List) {
          images = decoded
              .map((e) => DiaryImage.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      } catch (e) {
        debugPrint("Image decode error: $e");
      }
    }

    // Calculate the offset for the content area (after title, mood, and date)
    final contentTopOffset = 160.0; // Approximate height of header content

    return Scaffold(
      body: Stack(
        children: [
          // ---------- Background (fixed) ----------
          if (entry.bgImagePath != null && entry.bgImagePath!.isNotEmpty)
            // If bgImagePath refers to an asset
            Image.asset(
              entry.bgImagePath!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
          else if (entry.bgColor != null)
            Container(color: AppConverters.stringToColorDiary(entry.bgColor!))
          else
            Container(color: Colors.white),

          // ---------- Scrollable Content ----------
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              // Set a minimum height to ensure scrollability
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Stack(
                children: [
                  // ---------- Text Content ----------
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SafeArea(
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      ),
                      Text(
                        entry.title,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(entry.mood, style: const TextStyle(fontSize: 40)),
                      const SizedBox(height: 8),
                      Text(
                        _formatDate(entry.date),
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        entry.content,
                        style: const TextStyle(fontSize: 18, height: 1.5),
                      ),
                      const SizedBox(height: 120), // padding for floating buttons
                    ],
                  ),

                  // ---------- Stickers (scroll with content, adjusted position) ----------
                  ...stickers.map(
                    (s) => Positioned(
                      left: s.x,
                      top: s.y + contentTopOffset, // Adjust for header offset
                      child: Text(s.sticker, style: TextStyle(fontSize: s.size)),
                    ),
                  ),

                  // ---------- User-added images (scroll with content, adjusted position) ----------
                  ...images.map(
                    (img) => Positioned(
                      left: img.x,
                      top: img.y + contentTopOffset, // Adjust for header offset
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(img.imagePath),
                          width: img.width,
                          height: img.height,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ---------- Fixed App Bar (stays at top) ----------
           Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'edit_btn',
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DiaryEntryScreen(entry: entry),
                ),
              );
              if (result == true && context.mounted) {
                Navigator.pop(context, true); // Refresh on return
              }
            },
            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'delete_btn',
            backgroundColor: Colors.red,
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Delete Entry'),
                  content: const Text(
                    'Are you sure you want to delete this entry?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
              if (confirmed == true && context.mounted) {
                Navigator.pop(context, {'delete': entry.id});
              }
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    final DateTime newDate =
        AppConverters.stringToDateTime(date) ?? DateTime.now();
    final now = DateTime.now();
    final difference = now.difference(newDate);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${newDate.day}/${newDate.month}/${newDate.year}';
    }
  }
}