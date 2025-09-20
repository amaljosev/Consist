part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class BoardingInitial extends UserState {}

class PageChangeState extends UserState {
  final int pageIndex;

  const PageChangeState({required this.pageIndex});
  @override
  List<Object> get props => [pageIndex];
}

class ChooseAvatarState extends UserState {
  final String avatar;

  const ChooseAvatarState({required this.avatar});
  @override
  List<Object> get props => [avatar];
}

class ProfileSetupLoadingState extends UserState {}

class ProfileSetupSuccessState extends UserState {}

class ProfileSetupErrorState extends UserState {
  final String msg;

  const ProfileSetupErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class CheckUserLoginStatusLoadingState extends UserState {}

class NewUserState extends UserState {}

class UserLoggedState extends UserState {}

class UserProfileCreatedState extends UserState {}

class CheckUserLoginStatusErrorState extends UserState {
  final String msg;

  const CheckUserLoginStatusErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class FetchUserProfileLoadingState extends UserState {}
class FetchUserProfileSuccessState extends UserState {
  final UserAnalytics user;

  const FetchUserProfileSuccessState({required this.user});
  @override
  List<Object> get props => [user];
}
class FetchUserProfileErrorState extends UserState {
  final String msg;

  const FetchUserProfileErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}