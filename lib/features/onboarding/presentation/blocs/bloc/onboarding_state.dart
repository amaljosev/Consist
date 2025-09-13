part of 'onboarding_bloc.dart';

sealed class OnboardingState extends Equatable {
  final int currentPage;
  final int totalPages;
  final bool completed;

  const OnboardingState({
    required this.currentPage,
    required this.totalPages,
    this.completed = false,
  });

  @override
  List<Object> get props => [currentPage, totalPages, completed];
}

final class OnboardingInitial extends OnboardingState {
  const OnboardingInitial() : super(currentPage: 0, totalPages: 4);
}

final class OnboardingInProgress extends OnboardingState {
  const OnboardingInProgress({
    required super.currentPage,
    required super.totalPages,
  });
}

final class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted({
    required super.totalPages,
  }) : super(currentPage: totalPages - 1, completed: true);
}
