import 'package:consist/core/utils/converters.dart';
import 'package:consist/features/diary/data/models/diary_entry_model.dart';
import 'package:consist/features/diary/presentation/blocs/diary/diary_bloc.dart';
import 'package:consist/features/diary/presentation/pages/preview/diary_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryEntryCard extends StatelessWidget {
  final DiaryEntryModel entry;

  const DiaryEntryCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    // Generate a color based on the entry's mood or content
    final color = _generateColorFromText(entry.mood + entry.title);
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => DiaryPreviewScreen(entryId: entry.id)),
            );
            if (result == true && context.mounted) {
              context.read<DiaryBloc>().add(LoadDiaryEntries());
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date indicator
                Container(
                  width: 60,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _getDay(entry.date),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        _getMonth(entry.date),
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Mood emoji
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              entry.mood,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(width: 8),
                          
                          // Title
                          Expanded(
                            child: Text(
                              entry.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600, 
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Preview text
                      Text(
                        entry.preview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Time and tags (if available)
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            _getTime(entry.date),
                            style: TextStyle(color: Colors.grey[500], fontSize: 12),
                          ),
                          
                          // Add some spacing if you have tags in the future
                          // const SizedBox(width: 16),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          //   decoration: BoxDecoration(
                          //     color: Colors.grey[100],
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   child: Text(
                          //     "Personal",
                          //     style: TextStyle(color: Colors.grey[600], fontSize: 10),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDay(String date) {
    final DateTime newDate = AppConverters.stringToDateTime(date) ?? DateTime.now();
    return newDate.day.toString();
  }

  String _getMonth(String date) {
    final DateTime newDate = AppConverters.stringToDateTime(date) ?? DateTime.now();
    return newDate.toString().substring(5, 7); // Returns "MM" format
  }

  String _getTime(String date) {
    final DateTime newDate = AppConverters.stringToDateTime(date) ?? DateTime.now();
    final now = DateTime.now();
    final difference = now.difference(newDate);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${newDate.day}/${newDate.month}/${newDate.year}';
    }
  }

  // Helper function to generate a color from text
  Color _generateColorFromText(String text) {
    final hash = text.hashCode;
    return Color(hash & 0xFFFFFF).withOpacity(1.0).withBlue(150);
  }
}