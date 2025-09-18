
import 'dart:developer';

import 'package:consist/features/onboarding/domain/repository/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'boarding_event.dart';
part 'boarding_state.dart';

class BoardingBloc extends Bloc<BoardingEvent, BoardingState> {
  final UserRepository userRepository;
  BoardingBloc({required this.userRepository}) : super(BoardingInitial()) {
    on<PageChangeEvent>(
      (event, emit) => emit(PageChangeState(pageIndex: event.pageIndex)),
    );
    on<ChooseAvatarEvent>(
      (event, emit) => emit(ChooseAvatarState(avatar: event.avatar)),
    );
    on<ProfileSetupEvent>((event, emit) async {
      emit(ProfileSetupLoadingState());
      try {
        final prefs = await SharedPreferences.getInstance();
        final result = await userRepository.setupUser(
          avatar: event.avatar,
          username: event.username,
        );
        await prefs.setString('userId', result);
        emit(ProfileSetupSuccessState());
      } catch (e) {
        emit(ProfileSetupErrorState(msg: 'Profile setup failed'));
      }
    });

    on<UserLoggedEvent>((event, emit) async{
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLogged',true).then((value) => emit(UserLoggedState()),); 

      } catch (e) {
         log(e.toString());
      }
    });
    on<CheckUserLoginStatusEvent>((event, emit) async{
      try {
        final prefs = await SharedPreferences.getInstance();
        final isLogged= prefs.getBool('isLogged')??false; 
        await Future.delayed(Duration(seconds: 2));
       if (isLogged) {
         emit(UserLoggedState());
       } else {
          final userId= prefs.getString('userId'); 
          if (userId!=null&&userId.isNotEmpty) {
            emit(UserProfileCreatedState());
          } else {
            emit(NewUserState());
          }
       }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
