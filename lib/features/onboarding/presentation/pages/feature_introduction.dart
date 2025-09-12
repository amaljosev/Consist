import 'package:flutter/material.dart';

class FeatureIntroductionScreen extends StatelessWidget {
  const FeatureIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/onboarding/onboarding1.png',
            height: 250,
          ),
          const SizedBox(height: 40),
          const Text(
            'Build Better Habits, One Day at a Time',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Track routines + reflect on your journey with our integrated diary',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _FeatureItem(
            icon: Icons.track_changes,
            text: 'Log daily routines, set reminders, and visualize your progress streaks',
          ),
          const SizedBox(height: 16),
          _FeatureItem(
            icon: Icons.book,
            text: 'Connect habits with daily reflections for deeper insights',
          ),
          const SizedBox(height: 16),
          _FeatureItem(
            icon: Icons.analytics,
            text: 'Get personalized analytics about your behavior patterns',
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF4361EE), size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
          ),
        ),
      ],
    );
  }
}