import 'package:consist/core/app_colors.dart';
import 'package:consist/core/constants/diary_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DiaryUIHelpers {
  /// Date picker
  static void showDatePicker(
    BuildContext context,
    DateTime initialDate,
    Function(DateTime) onChanged,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: initialDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: onChanged,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }

  /// Emoji picker
  static void openEmojiPicker(
    BuildContext context,
    Function(String) onSelected,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: DiaryItems.moods.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (_, index) {
            final emoji = DiaryItems.moods[index];
            return GestureDetector(
              onTap: () {
                onSelected(emoji);
                Navigator.pop(context);
              },
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 24)),
              ),
            );
          },
        ),
      ),
    );
  }

  static void openColorPicker(
  BuildContext context,
  Function(Color) onSelected, 
) {
  showModalBottomSheet(
    context: context,
    builder: (_) => SafeArea(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: AppColors.myColors.length + 1, // +1 for clear selection
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (_, index) {
          if (index == 0) {
            // Clear selection item
            return GestureDetector(
              onTap: () {
                onSelected(Colors.white);
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.black12),
                ),
                child: const Icon(Icons.clear, color: Colors.black54),
              ),
            );
          }
          
          final colorIndex = index - 1; // Adjust index for the colors list
          final color = AppColors.myColors[colorIndex]['color'] as Color;
          return GestureDetector(
            onTap: () {
              onSelected(color);
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.black12),
              ),
            ),
          );
        },
      ),
    ),
  );
}

/// Background image picker
static void openBgImagePicker(
  BuildContext context,
  Function(String) onSelected, // Changed to accept null for clear selection
) {
  showModalBottomSheet(
    context: context,
    builder: (_) => SafeArea(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: DiaryItems.bgImages.length + 1, // +1 for clear selection
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          childAspectRatio: 0.5,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (_, index) {
          if (index == 0) {
            // Clear selection item
            return GestureDetector(
              onTap: () {
                onSelected(''); 
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.clear, size: 30, color: Colors.black54),
                    SizedBox(height: 8),
                    Text("Clear", style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
            );
          }
          
          final imgIndex = index - 1; // Adjust index for the images list
          final imgPath = DiaryItems.bgImages[imgIndex];
          return GestureDetector(
            onTap: () {
              onSelected(imgPath);
              Navigator.pop(context);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(imgPath, fit: BoxFit.cover),
            ),
          );
        },
      ),
    ),
  );
}

  /// Sticker picker
  static void openStickerPicker(
    BuildContext context,
    Function(String) onSelected,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: DiaryItems.emojis.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (_, index) {
            final sticker = DiaryItems.emojis[index];
            return GestureDetector(
              onTap: () {
                onSelected(sticker);
                Navigator.pop(context);
              },
              child: Center(
                child: Text(sticker, style: const TextStyle(fontSize: 28)),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Insert bullet into a TextEditingController
  static void insertBullet(TextEditingController controller) {
    final text = controller.text;
    controller.text = '$text\n• ';
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
  }
}
