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
          Image.asset('assets/img/onboarding/onboarding1.png', height: 250),
          const SizedBox(height: 40),
          Text(
            'Build Better Habits, One Day at a Time',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Track routines + reflect on your journey with our integrated diary',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _FeatureItem(
            icon: Icons.track_changes,
            text:
                'Log daily routines, set reminders, and visualize your progress streaks',
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
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 16),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}