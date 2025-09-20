part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends UserEvent {}

class PageChangeEvent extends UserEvent {
  final int pageIndex;

  const PageChangeEvent({required this.pageIndex});
  @override
  List<Object> get props => [pageIndex];
}

class ChooseAvatarEvent extends UserEvent {
  final String avatar;

  const ChooseAvatarEvent({required this.avatar});
  @override
  List<Object> get props => [avatar];
}

class ProfileSetupEvent extends UserEvent {
  final String username;
  final String avatar;

  const ProfileSetupEvent({required this.username, required this.avatar});

  @override
  List<Object> get props => [username, avatar];
}

class UserLoggedEvent extends UserEvent {}

class CheckUserLoginStatusEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class FetchUserProfileEvent extends UserEvent {
  @override
  List<Object> get props => [];
}
  
