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
          Image.network(
            'https://images.unsplash.com/photo-1563013544-824ae1b704d3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
            height: 200,
          ),
          const SizedBox(height: 30),
          const Text(
            'Your Data is Secure',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'We take privacy seriously. Your personal data remains yours alone.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          _PrivacyFeature(
            icon: Icons.security,
            title: 'Local Data Storage',
            description:
                'Your entries remain on your device until you choose to sync',
          ),
          const SizedBox(height: 16),
          _PrivacyFeature(
            icon: Icons.lock,
            title: 'Encryption',
            description: 'All data encrypted in transit and at rest',
          ),
          const SizedBox(height: 16),
          _PrivacyFeature(
            icon: Icons.shield,
            title: 'No Third-Party Sharing',
            description: 'We never sell your data to advertisers',
          ),
          const SizedBox(height: 16),
          _PrivacyFeature(
            icon: Icons.settings,
            title: 'Granular Controls',
            description: 'You decide what information to share',
          ),
          const SizedBox(height: 30),
          const Text(
            'By continuing, you agree to our Privacy Policy and Terms of Service',
            style: TextStyle(fontSize: 12, color: Colors.grey),
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
      children: [
        Icon(icon, color: const Color(0xFF38B000), size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
