import 'package:code/screens/splash_screen/logic/splash_event.dart';
import 'package:code/screens/splash_screen/logic/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenState()) {
    on<SplashScreenInitialEvent>(_splashScreenInitialEvent);
  }

  Future<void> _splashScreenInitialEvent(
      SplashScreenInitialEvent event, Emitter<SplashScreenState> emit) async {
    await Future.delayed(
      const Duration(seconds: 3),
    ).then((value) {
      emit(NavigateToHomeState());
    });
  }
}
