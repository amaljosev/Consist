import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingInitial()) {
    on<PageChanged>((event, emit) {
      emit(OnboardingInProgress(
        currentPage: event.page,
        totalPages: state.totalPages,
      ));
    });

    on<NextPage>((event, emit) {
      if (state.currentPage < state.totalPages - 1) {
        emit(OnboardingInProgress(
          currentPage: state.currentPage + 1,
          totalPages: state.totalPages,
        ));
      } else {
        emit(OnboardingCompleted(totalPages: state.totalPages));
      }
    });

    on<SkipOnboarding>((event, emit) {
      emit(OnboardingInProgress(
        currentPage: state.totalPages - 1,
        totalPages: state.totalPages,
      ));
    });

    on<CompleteOnboarding>((event, emit) {
      emit(OnboardingCompleted(totalPages: state.totalPages));
    });
  }
}
