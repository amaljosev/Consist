import 'package:flutter/material.dart';

class PrivacySafetyScreen extends StatelessWidget {
  const PrivacySafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img/onboarding/onboarding3.png', height: 200),
          const SizedBox(height: 30),
          Text(
            'Your Data Stays With You',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'All your information is stored only on your device. '
            'We do not upload, track, or share any data online.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          _PrivacyFeature(
            icon: Icons.storage,
            title: '100% Local Storage',
            description:
                'Your data is saved securely using an offline local database (SQLite).',
          ),
          const SizedBox(height: 16),

          _PrivacyFeature(
            icon: Icons.lock,
            title: 'Private by Design',
            description:
                'Since everything stays on your device, only you have access.',
          ),
          const SizedBox(height: 16),

          _PrivacyFeature(
            icon: Icons.shield,
            title: 'No Internet Sharing',
            description: 'We never send your data to servers or third parties.',
          ),
          const SizedBox(height: 16),

          _PrivacyFeature(
            icon: Icons.settings,
            title: 'You’re in Control',
            description:
                'You can edit or delete your data anytime directly from the app.',
          ),

          const SizedBox(height: 30),
          Text(
            'By continuing, you understand that all information stays local '
            'on your device only.',
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PrivacyFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const _PrivacyFeature({
    required this.icon,
    required this.title,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        Expanded(
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              Text(
                description,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
