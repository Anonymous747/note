import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:note/bloc/bloc_splash_screen/bloc.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial());

  @override
  Stream<SplashScreenState> mapEventToState(
    SplashScreenEvent event,
  ) async* {
    if (event is SplashScreenStartEvent) {
      try {
        yield SplashScreenSucces();
      } on PlatformException catch (e) {
        yield SplashScreenFailure(message: e.message);
      }
    }
  }
}
