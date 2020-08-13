import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_authentication/authentication_bloc.dart';
import 'package:note/bloc/bloc_authentication/bloc.dart';
import 'package:note/bloc/bloc_splash_screen/bloc.dart';
import 'package:note/screens/login_page.dart';

class BeginingBloc extends Bloc<BeginingEvent, BeginingState> {
  BeginingBloc() : super(BeginingInitial());

  @override
  Stream<BeginingState> mapEventToState(
    BeginingEvent event,
  ) async* {
    if (event is BeginingStartEvent) {
      yield BeginingLoading();
      try {
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc()..add(AuthenticationStarted()),
          child: LoginPage(),
        );
        print('success');
        await Future.delayed(
          Duration(seconds: 3),
        );
        yield BeginingSucces(colorIndex: 1);
      } on PlatformException catch (e) {
        yield BeginingFailure(message: e.message);
      }
    }
  }
}
