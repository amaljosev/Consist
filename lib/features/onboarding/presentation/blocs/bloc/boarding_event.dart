part of 'boarding_bloc.dart';

sealed class BoardingEvent extends Equatable {
  const BoardingEvent();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends BoardingEvent {}

class PageChangeEvent extends BoardingEvent {
  final int pageIndex;

  const PageChangeEvent({required this.pageIndex});
  @override
  List<Object> get props => [pageIndex];
}

class ChooseAvatarEvent extends BoardingEvent {
  final String avatar;

  const ChooseAvatarEvent({required this.avatar});
  @override
  List<Object> get props => [avatar];
}

class ProfileSetupEvent extends BoardingEvent {
  final String username;
  final String avatar;

  const ProfileSetupEvent({required this.username, required this.avatar});

  @override
  List<Object> get props => [username, avatar];
}
class UserLoggedEvent extends BoardingEvent {}

class CheckUserLoginStatusEvent extends BoardingEvent {
  @override
  List<Object> get props => [];
}
