import 'package:consist/features/onboarding/presentation/blocs/bloc/onboarding_bloc.dart';
import 'package:consist/features/onboarding/presentation/pages/feature_introduction.dart';
import 'package:consist/features/onboarding/presentation/pages/habit_selection.dart';
import 'package:consist/features/onboarding/presentation/pages/privacy_safety.dart';
import 'package:consist/features/onboarding/presentation/pages/profile_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (pageController.hasClients &&
              pageController.page?.round() != state.currentPage) {
            pageController.nextPage(
               duration: Duration(
                seconds: 1
               ),curve: Curves.easeIn
            );
          }

          if (state is OnboardingCompleted) {
            // TODO: Navigate to home screen
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSurface,
                      actions: [
                        BlocBuilder<OnboardingBloc, OnboardingState>(
                          builder: (context, state) {
                            return state.currentPage <
                                    state.totalPages - 1
                                ? TextButton(
                                    onPressed: () {
                                      context
                                          .read<OnboardingBloc>()
                                          .add(SkipOnboarding());
                                    },
                                    child: Text(
                                      'Skip',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (page) {
                          context
                              .read<OnboardingBloc>()
                              .add(PageChanged(page));
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

                // Indicators
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<OnboardingBloc, OnboardingState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(state.totalPages, (index) {
                          return Container(
                            width: 16,
                            height: 4,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: state.currentPage == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withValues(alpha: 0.2),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // FAB
          floatingActionButton:
              BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              return state.currentPage == state.totalPages - 1
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        context
                            .read<OnboardingBloc>()
                            .add(CompleteOnboarding());
                      },
                      label: const Text('Get Started'),
                    )
                  : FloatingActionButton(
                      onPressed: () {
                        context.read<OnboardingBloc>().add(NextPage());
                      },
                      child:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                    );
            },
          ),
        ),
      );
  }
}
