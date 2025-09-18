part of 'boarding_bloc.dart';

sealed class BoardingState extends Equatable {
  const BoardingState();

  @override
  List<Object> get props => [];
}

final class BoardingInitial extends BoardingState {}

class PageChangeState extends BoardingState {
  final int pageIndex;

  const PageChangeState({required this.pageIndex});
  @override
  List<Object> get props => [pageIndex];
}

class ChooseAvatarState extends BoardingState {
  final String avatar;

  const ChooseAvatarState({required this.avatar});
  @override
  List<Object> get props => [avatar];
}

class ProfileSetupLoadingState extends BoardingState {}

class ProfileSetupSuccessState extends BoardingState {}

class ProfileSetupErrorState extends BoardingState {
  final String msg;

  const ProfileSetupErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class CheckUserLoginStatusLoadingState extends BoardingState {}

class NewUserState extends BoardingState {}

class UserLoggedState extends BoardingState {}

class UserProfileCreatedState extends BoardingState {}

class CheckUserLoginStatusErrorState extends BoardingState {
  final String msg;

  const CheckUserLoginStatusErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}
