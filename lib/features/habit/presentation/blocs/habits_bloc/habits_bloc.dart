import 'package:flutter_bloc/flutter_bloc.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  HabitsBloc() : super(HabitsInitial()) {
    on<BottomNavScreenChangeEvent>(
      (event, emit) => emit(BottomNavScreenChangeState(index: event.index)),
    );
  }
}
