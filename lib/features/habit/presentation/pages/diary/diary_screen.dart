import 'package:flutter/material.dart';
// If you want emoji picker, add:
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DiaryEntryScreen();
  }
}

class DiaryEntryScreen extends StatefulWidget {
  const DiaryEntryScreen({super.key});

  @override
  State<DiaryEntryScreen> createState() => _DiaryEntryScreenState();
}

class _DiaryEntryScreenState extends State<DiaryEntryScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedMood = '🙂';
  ImageProvider? _selectedPhoto;

  // NEW: Customizations
  Color? _bgColor;
  ImageProvider? _bgImage;
  List<String> _stickers = [];

  // --- Methods ---
  void _selectMood(String mood) {
    setState(() => _selectedMood = mood);
  }

  void _pickPhoto() async {
    // Integrate with image_picker
  }

  void _saveEntry() {
    Navigator.pop(context, {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'date': _selectedDate,
      'mood': _selectedMood,
      'photo': _selectedPhoto,
      'bgColor': _bgColor,
      'bgImage': _bgImage,
      'stickers': _stickers,
    });
  }

  void _insertBullet() {
    final text = _descriptionController.text;
    _descriptionController.text = '$text\n• ';
    _descriptionController.selection = TextSelection.fromPosition(
      TextPosition(offset: _descriptionController.text.length),
    );
  }

  void _openBgColorPicker() {
    // Quick demo: pick random color
    final colors = [Colors.pink[50], Colors.blue[50], Colors.green[50], Colors.yellow[50]];
    setState(() {
      _bgColor = (colors..shuffle()).first;
      _bgImage = null; // remove image if color is selected
    });
  }

  void _openBgImagePicker() {
    // Replace with image picker in production
    setState(() {
      _bgImage = const AssetImage('assets/sample_bg.jpg');
      _bgColor = null; // remove color if image is selected
    });
  }

  void _openEmojiPicker() {
    // If using emoji_picker_flutter, you’d use showModalBottomSheet with EmojiPicker
    // For now, just simulate:
    setState(() {
      _descriptionController.text += ' 😍';
    });
  }

  void _addSticker() {
    // Simulate adding a sticker (from a predefined set)
    setState(() => _stickers.add('⭐️'));
  }

  // --- UI ---

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.surface;
    final shadow = base == Colors.white ? Colors.grey[300] : Colors.black26;

    BoxDecoration softDeco(double radius) => BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(offset: const Offset(4, 4), blurRadius: 8, color: shadow!),
            const BoxShadow(offset: Offset(-4, -4), blurRadius: 8, color: Colors.white),
          ],
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Entry'),
        elevation: 0,
        backgroundColor: base,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: _bgColor ?? base,
          image: _bgImage != null
              ? DecorationImage(image: _bgImage!, fit: BoxFit.cover)
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Date + Mood row
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: softDeco(16),
                      child: Center(
                        child: Text(
                          '${_selectedDate.toLocal()}'.split(' ')[0],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: softDeco(16),
                    child: GestureDetector(
                      onTap: () {
                        // open mood selector
                      },
                      child: Text(_selectedMood,
                          style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Title field
              Container(
                decoration: softDeco(16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                  ),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 20),

              // Description field
              Expanded(
                child: Container(
                  decoration: softDeco(16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What’s on your mind?',
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Stickers display (if any)
              if (_stickers.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _stickers
                      .map((s) => Text(s, style: const TextStyle(fontSize: 28)))
                      .toList(),
                ),

              // Photo (optional)
              if (_selectedPhoto != null)
                Container(
                  height: 120,
                  decoration: softDeco(16),
                  clipBehavior: Clip.hardEdge,
                  child: Image(image: _selectedPhoto!, fit: BoxFit.cover),
                ),
              const SizedBox(height: 12),

              // Action buttons row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextButton.icon(
                        onPressed: _pickPhoto,
                        icon: const Icon(Icons.photo),
                        label: const Text('Photo')),
                    TextButton.icon(
                        onPressed: _openBgColorPicker,
                        icon: const Icon(Icons.palette),
                        label: const Text('BG Color')),
                    TextButton.icon(
                        onPressed: _openBgImagePicker,
                        icon: const Icon(Icons.image),
                        label: const Text('BG Image')),
                    TextButton.icon(
                        onPressed: _openEmojiPicker,
                        icon: const Icon(Icons.emoji_emotions),
                        label: const Text('Emoji')),
                    TextButton.icon(
                        onPressed: _insertBullet,
                        icon: const Icon(Icons.format_list_bulleted),
                        label: const Text('Bullet')),
                    TextButton.icon(
                        onPressed: _addSticker,
                        icon: const Icon(Icons.sticky_note_2),
                        label: const Text('Sticker')),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveEntry,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Save Entry',
                      style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
