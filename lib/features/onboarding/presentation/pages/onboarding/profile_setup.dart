import 'package:consist/core/constants/onboarding_items.dart';
import 'package:consist/features/onboarding/presentation/blocs/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({
    super.key,
    required this.nameCtrl,
    required this.selectedAvatar,
  });
  final TextEditingController nameCtrl;
  final String selectedAvatar;
  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  @override
  void dispose() {
    widget.nameCtrl.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/onboarding/onboarding2.png', height: 200),
            const SizedBox(height: 30),
            Text(
              'Personalize Your Experience',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'We\'ll use this to personalize your experience and celebrate your progress',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: widget.nameCtrl,
              focusNode: _nameFocusNode,
              decoration: InputDecoration(
                labelText: 'Your Name or Nickname',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) async {},
              onSubmitted: (_) => _nameFocusNode.unfocus(),
            ),
            const SizedBox(height: 30),
            const Text(
              'Choose an avatar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            _AvatarSelectionGrid(selectedAvatar: widget.selectedAvatar),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _AvatarSelectionGrid extends StatelessWidget {
  final String selectedAvatar;
  const _AvatarSelectionGrid({required this.selectedAvatar});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      alignment: WrapAlignment.center,
      children: List.generate(OnboardingItems.avatars.length, (index) {
        final avatarKey = 'avatar$index';
        return _AvatarOption(
          imageUrl: OnboardingItems.avatars[index],
          isSelected: selectedAvatar == avatarKey,
          onTap: () => context.read<UserBloc>().add(
            ChooseAvatarEvent(avatar: avatarKey),
          ),
        );
      }),
    );
  }
}

class _AvatarOption extends StatelessWidget {
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  const _AvatarOption({
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            width: 3,
          ),
        ),
        child: ClipOval(
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: const Icon(Icons.person, size: 40, color: Colors.grey),
              );
            },
          ),
        ),
      ),
    );
  }
}
