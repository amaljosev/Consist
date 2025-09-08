import 'package:consist/features/diary/presentation/blocs/diary_entry/diary_entry_bloc.dart';
import 'package:consist/features/diary/presentation/widgets/diary_ui_helpers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryEntryScreen extends StatelessWidget {
  const DiaryEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DiaryEntryBloc(),
      child: const DiaryEntryForm(),
    );
  }
}

class DiaryEntryForm extends StatelessWidget {
  const DiaryEntryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiaryEntryBloc, DiaryEntryState>(
      builder: (context, state) {
        final bloc = context.read<DiaryEntryBloc>();

        BoxDecoration softDeco(double radius) {
          final base = Theme.of(context).colorScheme.surface;
          final shadow = base == Colors.white
              ? Colors.grey[300]
              : Colors.black26;
          return BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 8,
                color: shadow!,
              ),
              const BoxShadow(
                offset: Offset(-4, -4),
                blurRadius: 8,
                color: Colors.white,
              ),
            ],
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Entry'),
            backgroundColor:
                state.bgColor ?? Theme.of(context).colorScheme.surface,
          ),
          body: Container(
            decoration: BoxDecoration(
              color: state.bgColor ?? Theme.of(context).colorScheme.surface,
              image: state.bgImage != null
                  ? DecorationImage(image: state.bgImage!, fit: BoxFit.cover)
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Date + Mood
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => DiaryUIHelpers.showDatePicker(
                            context,
                            state.date,
                            (val) => bloc.add(DateChanged(val)),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: softDeco(16),
                            child: Center(
                              child: Text(
                                '${state.date.toLocal()}'.split(' ')[0],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: softDeco(16),
                        child: GestureDetector(
                          onTap: () =>
                              DiaryUIHelpers.openEmojiPicker(context, (emoji) {
                                bloc.add(MoodChanged(emoji));
                              }),
                          child: Text(
                            state.mood,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Container(
                    decoration: softDeco(16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: TextField(
                      onChanged: (value) => bloc.add(TitleChanged(value)),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                      ),
                      controller: TextEditingController(text: state.title),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description + Stickers (Stack)
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: softDeco(16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: TextField(
                            onChanged: (value) =>
                                bloc.add(DescriptionChanged(value)),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'What’s on your mind?',
                            ),
                            controller: TextEditingController(
                              text: state.description,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            expands: true,
                          ),
                        ),
                        ...state.stickers.map(
                          (s) => Positioned(
                            left: s.x,
                            top: s.y,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                final newX = s.x + details.delta.dx;
                                final newY = s.y + details.delta.dy;
                                context.read<DiaryEntryBloc>().add(
                                  UpdateStickerPosition(s.id, newX, newY),
                                );
                              },
                              onTap: () async {
                                // Show a menu to edit or remove
                                final action =
                                    await showModalBottomSheet<String>(
                                      context: context,
                                      builder: (ctx) {
                                        return SafeArea(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading: const Icon(
                                                  Icons.delete,
                                                ),
                                                title: const Text(
                                                  'Remove Sticker',
                                                ),
                                                onTap: () => Navigator.pop(
                                                  ctx,
                                                  'remove',
                                                ),
                                              ),
                                              ListTile(
                                                leading: const Icon(
                                                  Icons.zoom_in,
                                                ),
                                                title: const Text(
                                                  'Increase Size',
                                                ),
                                                onTap: () => Navigator.pop(
                                                  ctx,
                                                  'bigger',
                                                ),
                                              ),
                                              ListTile(
                                                leading: const Icon(
                                                  Icons.zoom_out,
                                                ),
                                                title: const Text(
                                                  'Decrease Size',
                                                ),
                                                onTap: () => Navigator.pop(
                                                  ctx,
                                                  'smaller',
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );

                                if (action == 'remove') {
                                  context.read<DiaryEntryBloc>().add(
                                    RemoveSticker(s.id),
                                  );
                                } else if (action == 'bigger') {
                                  context.read<DiaryEntryBloc>().add(
                                    UpdateStickerSize(s.id, s.size + 4),
                                  );
                                } else if (action == 'smaller') {
                                  context.read<DiaryEntryBloc>().add(
                                    UpdateStickerSize(
                                      s.id,
                                      (s.size - 4).clamp(12, 100),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                s.sticker,
                                style: TextStyle(
                                  fontSize: s.size,
                                ), // <-- use dynamic size
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Actions
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.photo),
                          label: const Text('Photo'),
                        ),
                        TextButton.icon(
                          onPressed: () =>
                              DiaryUIHelpers.openColorPicker(context, (color) {
                                bloc.add(BgColorChanged(color));
                              }),
                          icon: const Icon(Icons.palette),
                          label: const Text('BG Color'),
                        ),
                        TextButton.icon(
                          onPressed: () => DiaryUIHelpers.openBgImagePicker(
                            context,
                            (image) {
                              bloc.add(BgImageChanged(image));
                            },
                          ),
                          icon: const Icon(Icons.image),
                          label: const Text('BG Image'),
                        ),
                        TextButton.icon(
                          onPressed: () => bloc.add(BulletInserted()),
                          icon: const Icon(Icons.format_list_bulleted),
                          label: const Text('Bullet'),
                        ),
                        TextButton.icon(
                          onPressed: () => DiaryUIHelpers.openStickerPicker(
                            context,
                            (sticker) {
                              bloc.add(StickerAdded(sticker));
                            },
                          ),
                          icon: const Icon(Icons.emoji_emotions),
                          label: const Text('Sticker'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => bloc.add(SaveEntry()),
                      child: const Text('Save Entry'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DraggableSticker extends StatefulWidget {
  final String sticker;
  final double initialX;
  final double initialY;
  final Function(double x, double y) onPositionChanged;

  const DraggableSticker({
    super.key,
    required this.sticker,
    required this.initialX,
    required this.initialY,
    required this.onPositionChanged,
  });

  @override
  State<DraggableSticker> createState() => _DraggableStickerState();
}

class _DraggableStickerState extends State<DraggableSticker> {
  late double dx;
  late double dy;

  @override
  void initState() {
    super.initState();
    dx = widget.initialX;
    dy = widget.initialY;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          dx += details.delta.dx;
          dy += details.delta.dy;
        });
        widget.onPositionChanged(dx, dy);
      },
      child: Transform.translate(
        offset: Offset(dx, dy),
        child: Text(widget.sticker, style: const TextStyle(fontSize: 28)),
      ),
    );
  }
}
