import 'package:consist/core/constants/habits_items.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  actions: [
                    if (_currentPage < 3)
                      TextButton(
                        onPressed: () {
                          if (_currentPage < 3) {
                            _pageController.jumpToPage(3);
                          } else {
                            // Complete onboarding and navigate to main app
                          }
                        },
                        child: Text(
                          'Skip',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: const [
                      FeatureIntroductionScreen(),
                      ProfileSetupScreen(),
                      PrivacySafetyScreen(),
                      HabitSelectionScreen(),
                    ],
                  ),
                ),
              ],
            ),

            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    width: 16,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: _currentPage == index
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.2),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _currentPage == 3
          ? FloatingActionButton.extended(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              label: Text('Get Started'),
            )
          : FloatingActionButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            ),
    );
  }
}

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

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});
  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _nameController = TextEditingController();
  List<String> avatars = [
    'assets/img/onboarding/bear.jpg',
    'assets/img/onboarding/cat.jpeg',
    'assets/img/onboarding/dog.jpeg',
    'assets/img/onboarding/elephant.jpg',
    'assets/img/onboarding/fox.jpg',
    'assets/img/onboarding/graf.jpg',
    'assets/img/onboarding/lion.jpg',
    'assets/img/onboarding/onboarding1.png',
    'assets/img/onboarding/owl.jpg',
    'assets/img/onboarding/panda.jpg',
    'assets/img/onboarding/penguin.jpg',
    'assets/img/onboarding/rabbit.jpg',
    'assets/img/onboarding/tiger.jpg',
  ];
  String? selectedAvatar;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
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
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Your Name or Nickname',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Choose an avatar',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            children: List.generate(
              avatars.length,
              (index) => _AvatarOption(
                imageUrl: avatars[index],
                isSelected: selectedAvatar == 'avatar$index',
                onTap: () => setState(() => selectedAvatar = 'avatar$index'),
              ),
            ),
          ),
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
            'Your Data is Secure',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'We take privacy seriously. Your personal data remains yours alone.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
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
          Text(
            'By continuing, you agree to our Privacy Policy and Terms of Service',
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

class HabitSelectionScreen extends StatefulWidget {
  const HabitSelectionScreen({super.key});

  @override
  State<HabitSelectionScreen> createState() => _HabitSelectionScreenState();
}

class _HabitSelectionScreenState extends State<HabitSelectionScreen> {
  // track selected habits by id
  final Set<String> _selectedHabits = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Image.asset('assets/img/onboarding/onboarding4.png', height: 180),
          const SizedBox(height: 20),
          Text(
            'Choose Your Habits',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          Text(
            'Select habits you want to build or use our templates to get started',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Habit Categories + Habits
          Expanded(
            child: ListView.builder(
              itemCount: HabitsItems.habitCategories.length,
              itemBuilder: (context, categoryIndex) {
                final category = HabitsItems.habitCategories[categoryIndex];

                // Skip "All" (id:0) if you don’t want to show it
                if (category['id'] == '0') return const SizedBox();

                // Get all habits for this category
                final habits = HabitsItems.habitList
                    .where((h) => h['categoryId'] == category['id'])
                    .toList();

                if (habits.isEmpty) return const SizedBox();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          category['icon'],
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category['name'],
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3,
                          ),
                      itemCount: habits.length,
                      itemBuilder: (context, habitIndex) {
                        final habit = habits[habitIndex];
                        final isSelected = _selectedHabits.contains(
                          habit['id'],
                        );
                        return _HabitChip(
                          name: habit['name'],
                          icon: habit['icon'],
                          selected: isSelected,
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedHabits.remove(habit['id']);
                              } else {
                                _selectedHabits.add(habit['id']);
                              }
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitChip extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _HabitChip({
    required this.name,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,

                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: selected ? Colors.white : const Color(0xFF333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
