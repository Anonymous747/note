import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/begining_bloc/bloc.dart';
import 'package:note/bloc/bloc_authentication/authentication_bloc.dart';
import 'package:note/bloc/bloc_authentication/bloc.dart';
import 'package:note/bloc/bloc_creation/bloc.dart';
import 'package:note/screens/creation_note_page/make_note_activiry.dart';
import 'package:note/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeginingBloc extends Bloc<BeginingEvent, BeginingState> {
  BeginingBloc() : super(BeginingInitial());

  @override
  Stream<BeginingState> mapEventToState(
    BeginingEvent event,
  ) async* {
    if (event is BeginingStartEvent) {
      yield BeginingLoading();
      try {
        SharedPreferences pref = await SharedPreferences.getInstance();
        int colorIndex = pref.getInt('color');

        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc()..add(AuthenticationStarted()),
          child: LoginPage(
            colorIndex: colorIndex,
          ),
        );
        BlocProvider<CreationBloc>(
          create: (context) => CreationBloc(),
          child: MakeNoteActivity(
            colorIndex: colorIndex,
          ),
        );

        if (pref.getBool('isEntered') ?? false) {
          yield BeginingSuccesButEnered(colorIndex: colorIndex);
        } else {
          yield BeginingSucces(colorIndex: colorIndex);
        }
      } on PlatformException catch (e) {
        yield BeginingFailure(message: e.message);
      }
    }
  }
}
