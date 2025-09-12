import 'package:flutter/material.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? selectedAvatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            '',
            height: 200,
          ),
          const SizedBox(height: 30),
          const Text(
            'Personalize Your Experience',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'We\'ll use this to personalize your experience and celebrate your progress',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Your Name or Nickname',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Choose an avatar (optional)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
         Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    _AvatarOption(
      imageUrl: '',
      isSelected: selectedAvatar == 'avatar1',
      onTap: () => setState(() => selectedAvatar = 'avatar1'),
    ),
    _AvatarOption(
      imageUrl: '',
      isSelected: selectedAvatar == 'avatar2',
      onTap: () => setState(() => selectedAvatar = 'avatar2'),
    ),
    _AvatarOption(
      imageUrl: '',
      isSelected: selectedAvatar == 'avatar3',
      onTap: () => setState(() => selectedAvatar = 'avatar3'),
    ),
  ],
)
        ],
      ),
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
            color: isSelected ? const Color(0xFF4361EE) : Colors.transparent,
            width: 3,
          ),
        ),
        child: ClipOval(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: const Icon(Icons.person, size: 40, color: Colors.grey),
              );
            },
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}