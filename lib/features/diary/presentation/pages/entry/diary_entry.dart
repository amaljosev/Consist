import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:consist/features/diary/data/models/diary_entry_model.dart';
import 'package:consist/features/diary/domain/entities/sticker_model.dart';
import 'package:consist/features/diary/presentation/blocs/diary/diary_bloc.dart';
import 'package:consist/features/diary/presentation/blocs/diary_entry/diary_entry_bloc.dart';
import 'package:consist/features/diary/presentation/widgets/diary_ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;

class DiaryEntryScreen extends StatelessWidget {
  const DiaryEntryScreen({super.key, required this.entry});
  final DiaryEntryModel? entry;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DiaryEntryBloc(),
      child: DiaryEntryForm(entry: entry),
    );
  }
}

class DiaryEntryForm extends StatefulWidget {
  const DiaryEntryForm({super.key, required this.entry});
  final DiaryEntryModel? entry;
  @override
  State<DiaryEntryForm> createState() => _DiaryEntryFormState();
}

class _DiaryEntryFormState extends State<DiaryEntryForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _descriptionKey = GlobalKey();
  late DiaryEntryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<DiaryEntryBloc>();
    if (widget.entry != null) {
      _bloc.add(InitializeDiaryEntry(widget.entry));
      _titleController.text = widget.entry?.title ?? "";
      _descriptionController.text = widget.entry?.content ?? "";
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiaryEntryBloc, DiaryEntryState>(
      builder: (context, state) {
        return Scaffold(body: _buildBackground(state, context));
      },
    );
  }

  Widget _buildBackground(DiaryEntryState state, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: state.bgColor ?? Theme.of(context).colorScheme.surface,
        image: state.bgImage.isNotEmpty
            ? DecorationImage(
                image: AssetImage(state.bgImage),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Container(color: Colors.white54),
            _buildContent(state, context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(DiaryEntryState state, BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          forceMaterialTransparency: true,
        ),
        Expanded(
          child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildCustomScrollView(state, context),
            ),
          ),
        ),
        _buildBottomSection(context, state),
      ],
    );
  }

  Widget _buildCustomScrollView(DiaryEntryState state, BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // Header section with date and mood
        SliverToBoxAdapter(child: _buildHeaderSection(state, context)),

        // Title field
        SliverToBoxAdapter(child: _buildTitleField(context)),

        // Description section with stickers and images
        SliverToBoxAdapter(child: _buildDescriptionSection(state, context)),

        // Add some extra space at the bottom
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  Widget _buildHeaderSection(DiaryEntryState state, BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        _buildDateSelector(state, context),
        _buildMoodSelector(state, context),
      ],
    );
  }

  Widget _buildDateSelector(DiaryEntryState state, BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _selectDate(context, state),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: _buildSoftDecoration(context, 24),
          child: Row(
            children: [
              _buildDateContent(state, context),
              const Spacer(),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateContent(DiaryEntryState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          intl.DateFormat('dd').format(state.date),
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 34,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          intl.DateFormat('EEEE').format(state.date),
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        Text(
          intl.DateFormat('MMMM yyyy').format(state.date),
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }

  Widget _buildMoodSelector(DiaryEntryState state, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: _buildSoftDecoration(context, 16),
      child: GestureDetector(
        onTap: () => _selectMood(context),
        child: Text(state.mood, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  Widget _buildTitleField(BuildContext context) {
    return TextFormField(
      onChanged: (value) => _bloc.add(TitleChanged(value)),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w900,
          fontSize: 24,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w900,
        fontSize: 24,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      maxLines: null,
      maxLength: 50,
      controller: _titleController,
      textDirection: TextDirection.ltr,
    );
  }

  Widget _buildDescriptionSection(DiaryEntryState state, BuildContext context) {
    return Container(
      key: _descriptionKey,
      constraints: const BoxConstraints(minHeight: 200),
      child: Stack(
        children: [
          // Text field
          TextFormField(
            onChanged: (value) => _bloc.add(DescriptionChanged(value)),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'What\'s on your mind?',
            ),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            controller: _descriptionController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onTap: () => _bloc.add(DeselectAll()),
          ),

          // Stickers and images overlay
          ..._buildStickers(state),
          ..._buildImages(state),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, DiaryEntryState state) {
    return Container(
      padding: const EdgeInsets.all(20),

      child: Column(
        children: [
          _buildActionButtons(context),
          const SizedBox(height: 16),
          _buildSaveButton(context, state),
        ],
      ),
    );
  }

  List<Widget> _buildStickers(DiaryEntryState state) {
    return state.stickers
        .map((sticker) => _buildSticker(sticker, state))
        .toList();
  }

  Widget _buildSticker(StickerModel sticker, DiaryEntryState state) {
    final isSelected = state.selectedStickerId == sticker.id;

    return Positioned(
      left: sticker.x,
      top: sticker.y,
      child: GestureDetector(
        onTap: () {
          _bloc.add(SelectSticker(sticker.id));
        },
        onDoubleTap: () => _showStickerMenu(sticker),
        onLongPress: () => _showStickerMenu(sticker),
        onScaleUpdate: isSelected
            ? (details) {
                final newX = (sticker.x + details.focalPointDelta.dx)
                    .toDouble();
                final newY = (sticker.y + details.focalPointDelta.dy)
                    .toDouble();
                _bloc.add(UpdateStickerPosition(sticker.id, newX, newY));
                final scaledSize = (sticker.size * details.scale).clamp(
                  12.0,
                  200.0,
                );
                _bloc.add(UpdateStickerSize(sticker.id, scaledSize.toDouble()));
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: isSelected
              ? BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                )
              : null,
          padding: const EdgeInsets.all(4),
          child: Text(
            sticker.sticker,
            style: TextStyle(fontSize: sticker.size),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildImages(DiaryEntryState state) {
    return state.images.map((image) => _buildImage(image, state)).toList();
  }

  Widget _buildImage(DiaryImage image, DiaryEntryState state) {
    final isSelected = state.selectedImageId == image.id;

    return Positioned(
      left: image.x,
      top: image.y,
      child: GestureDetector(
        onTap: () {
          _bloc.add(SelectImage(image.id));
        },
        onDoubleTap: () => _showImageMenu(image),
        onLongPress: () => _showImageMenu(image),
        onScaleUpdate: isSelected
            ? (details) {
                final newX = (image.x + details.focalPointDelta.dx).toDouble();
                final newY = (image.y + details.focalPointDelta.dy).toDouble();
                _bloc.add(UpdateImagePosition(image.id, newX, newY));
                final newScale = (image.scale * details.scale).clamp(0.5, 3.0);
                _bloc.add(UpdateImageSize(image.id, newScale.toDouble()));
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: isSelected
              ? BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                )
              : null,
          padding: const EdgeInsets.all(4),
          child: Transform.scale(
            scale: image.scale,
            child: Image.file(
              File(image.imagePath),
              width: image.width,
              height: image.height,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      decoration: _buildActionButtonsDecoration(context),
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildActionButton(
              icon: Icons.photo,
              label: 'Photo',
              onPressed: _onPhotoPressed,
              context: context,
            ),
            _buildActionButton(
              icon: Icons.palette,
              label: 'BG Color',
              onPressed: _onBgColorPressed,
              context: context,
            ),
            _buildActionButton(
              icon: Icons.image,
              label: 'BG Image',
              onPressed: _onBgImagePressed,
              context: context,
            ),
            _buildActionButton(
              icon: Icons.format_list_bulleted,
              label: 'Bullet',
              onPressed: _onBulletPressed,
              context: context,
            ),
            _buildActionButton(
              icon: Icons.emoji_emotions,
              label: 'Sticker',
              onPressed: _onStickerPressed,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, DiaryEntryState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final entry = DiaryEntryModel(
            id: widget.entry == null
                ? DateTime.now().toIso8601String()
                : widget.entry!.id,
            title: _titleController.text.trim(),
            date: state.date.toIso8601String(),
            preview: _descriptionController.text.trim(),
            mood: state.mood,
            content: _descriptionController.text,
            createdAt: widget.entry == null
                ? DateTime.now().toIso8601String()
                : widget.entry!.createdAt,
            updatedAt: DateTime.now().toIso8601String(),
            bgColor: "${state.bgColor ?? Colors.white.toString()}",
            stickersJson: jsonEncode(
              state.stickers.map((s) => s.toJson()).toList(),
            ),
            imagesJson: jsonEncode(
              state.images.map((i) => i.toJson()).toList(),
            ),
            bgImagePath: state.bgImage,
          );

          if (widget.entry != null) {
            context.read<DiaryBloc>().add(UpdateDiaryEntry(entry));
          } else {
            context.read<DiaryBloc>().add(AddDiaryEntry(entry));
          }
          Navigator.pop(
            context,
            widget.entry != null ? widget.entry!.id : true,
          );
        },
        child: Text(widget.entry != null ? 'Update diary' : 'Save'),
      ),
    );
  }

  BoxDecoration _buildSoftDecoration(BuildContext context, double radius) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        ],
      ),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        width: 1.5,
      ),
    );
  }

  BoxDecoration _buildActionButtonsDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.surface.withValues(alpha: 0.9),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Event handlers
  void _selectDate(BuildContext context, DiaryEntryState state) {
    DiaryUIHelpers.showDatePicker(
      context,
      state.date,
      (val) => _bloc.add(DateChanged(val)),
    );
  }

  void _selectMood(BuildContext context) {
    DiaryUIHelpers.openEmojiPicker(
      context,
      (emoji) => _bloc.add(MoodChanged(emoji)),
    );
  }

  Future<void> _showStickerMenu(StickerModel sticker) async {
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => _buildStickerMenu(ctx),
    );

    if (action == 'remove' && context.mounted) {
      _bloc.add(RemoveSticker(sticker.id));
    } else if (action == 'bigger' && context.mounted) {
      _bloc.add(UpdateStickerSize(sticker.id, sticker.size + 4));
    } else if (action == 'smaller' && context.mounted) {
      _bloc.add(
        UpdateStickerSize(sticker.id, (sticker.size - 4).clamp(12, 100)),
      );
    }
  }

  Future<void> _showImageMenu(DiaryImage image) async {
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => _buildImageMenu(ctx),
    );

    if (action == 'remove' && context.mounted) {
      _bloc.add(RemoveImage(image.id));
    } else if (action == 'bigger' && context.mounted) {
      _bloc.add(UpdateImageSize(image.id, image.scale + 0.2));
    } else if (action == 'smaller' && context.mounted) {
      _bloc.add(UpdateImageSize(image.id, (image.scale - 0.2).clamp(0.5, 3.0)));
    }
  }

  Widget _buildStickerMenu(BuildContext ctx) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Remove Sticker'),
            onTap: () => Navigator.pop(ctx, 'remove'),
          ),
          ListTile(
            leading: const Icon(Icons.zoom_in),
            title: const Text('Increase Size'),
            onTap: () => Navigator.pop(ctx, 'bigger'),
          ),
          ListTile(
            leading: const Icon(Icons.zoom_out),
            title: const Text('Decrease Size'),
            onTap: () => Navigator.pop(ctx, 'smaller'),
          ),
        ],
      ),
    );
  }

  Widget _buildImageMenu(BuildContext ctx) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Remove Image'),
            onTap: () => Navigator.pop(ctx, 'remove'),
          ),
          ListTile(
            leading: const Icon(Icons.zoom_in),
            title: const Text('Increase Size'),
            onTap: () => Navigator.pop(ctx, 'bigger'),
          ),
          ListTile(
            leading: const Icon(Icons.zoom_out),
            title: const Text('Decrease Size'),
            onTap: () => Navigator.pop(ctx, 'smaller'),
          ),
        ],
      ),
    );
  }

  void _onPhotoPressed() {
    _pickImageFromGallery();
  }

  void _pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null && context.mounted) {
        // Calculate position based on current scroll
        final position = _calculateCenterPosition();
        _bloc.add(ImageAdded(image.path, position.dx, position.dy));
      }
    } catch (e) {
      log('Failed to pick image: $e');
    }
  }

  void _onBgColorPressed() {
    DiaryUIHelpers.openColorPicker(
      context,
      (color) => _bloc.add(BgColorChanged(color)),
    );
  }

  void _onBgImagePressed() {
    DiaryUIHelpers.openBgImagePicker(
      context,
      (image) => _bloc.add(BgImageChanged(image)),
    );
  }

  void _onBulletPressed() {
    DiaryUIHelpers.insertBullet(_descriptionController);
  }

  void _onStickerPressed() {
    DiaryUIHelpers.openStickerPicker(context, (sticker) {
      // Calculate position based on current scroll
      final position = _calculateCenterPosition();
      _bloc.add(StickerAdded(sticker, position.dx, position.dy));
    });
  }

  // Calculate the center position of the visible area
  Offset _calculateCenterPosition() {
    try {
      // Get the render box of the description section
      final RenderBox renderBox =
          _descriptionKey.currentContext?.findRenderObject() as RenderBox;
      final size = renderBox.size;

      // Calculate the visible area based on scroll position
      final scrollOffset = _scrollController.offset;
      final viewportHeight =
          MediaQuery.of(context).size.height - 200; // Approximate visible area

      // Calculate the center of the visible area
      final centerX = size.width / 2;
      final centerY =
          (scrollOffset + viewportHeight / 2) - 100; // Adjust for header height

      return Offset(centerX, centerY);
    } catch (e) {
      // Fallback to center of the description section
      return const Offset(150, 150);
    }
  }
}
