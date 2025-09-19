import 'package:consist/features/home_screen.dart';
import 'package:consist/features/onboarding/presentation/blocs/bloc/user_bloc.dart';
import 'package:consist/features/onboarding/presentation/pages/onboarding/feature_introduction.dart';
import 'package:consist/features/onboarding/presentation/pages/onboarding/privacy_safety.dart';
import 'package:consist/features/onboarding/presentation/pages/onboarding/profile_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, this.pageIdx});
  final int? pageIdx;
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final PageController pageController = PageController();
  Set<String> selectedHabits = {};
  String avatar = '';
  int pageIndex = 0;
  @override
  void initState() {
    if (widget.pageIdx != null) {
      context.read<UserBloc>().add(
        PageChangeEvent(pageIndex: widget.pageIdx!),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is PageChangeState) {
          pageIndex = state.pageIndex;
          pageController.animateToPage(
            state.pageIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
        if (state is ChooseAvatarState) {
          avatar = state.avatar;
        }
        if (state is ProfileSetupSuccessState) {
          FocusScope.of(context).unfocus();
          context.read<UserBloc>().add(
            PageChangeEvent(pageIndex: pageIndex + 1),
          );
        }
        if (state is UserLoggedState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  // onPageChanged: (page) {
                  //   context.read<UserBloc>().add(
                  //     PageChangeEvent(pageIndex: page),
                  //   );
                  // },
                  children: [
                    FeatureIntroductionScreen(),
                    ProfileSetupScreen(
                      nameCtrl: _nameController,
                      selectedAvatar: avatar,
                    ),
                    PrivacySafetyScreen(),
                  ],
                ),

                // Indicators
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        width: 16,
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: pageIndex == index
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

          // FAB
          floatingActionButton: pageIndex == 2
              ? FloatingActionButton.extended(
                  onPressed: () =>
                      context.read<UserBloc>().add(UserLoggedEvent()),
                  label: const Text('Get Started'),
                )
              : pageIndex == 1
              ? FloatingActionButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter your name or nickname'),
                        ),
                      );
                    } else {
                      if (avatar.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please choose a avatar')),
                        );
                      } else {
                        context.read<UserBloc>().add(
                          ProfileSetupEvent(
                            avatar: avatar,
                            username: _nameController.text,
                          ),
                        );
                      }
                    }
                  },
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                )
              : FloatingActionButton(
                  onPressed: () {
                    context.read<UserBloc>().add(
                      PageChangeEvent(pageIndex: pageIndex + 1),
                    );
                  },
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
        );
      },
    );
  }
}
