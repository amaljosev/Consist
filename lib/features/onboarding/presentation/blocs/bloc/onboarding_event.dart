part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

final class PageChanged extends OnboardingEvent {
  final int page;
  const PageChanged(this.page);

  @override
  List<Object> get props => [page];
}

final class NextPage extends OnboardingEvent {}

final class SkipOnboarding extends OnboardingEvent {}

final class CompleteOnboarding extends OnboardingEvent {}
