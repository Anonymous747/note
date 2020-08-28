import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_authentication/authentication_observer.dart';
import 'package:note/screens/add_note_page.dart';
import 'package:note/screens/home_page.dart';
import 'package:note/screens/login_page.dart';
import 'package:note/startPages/nickname_page.dart';
import 'package:note/screens/note_page.dart';
import 'package:note/startPages/first_screen.dart';
import 'package:note/screens/splash_screen.dart';
import 'package:note/startPages/start_page.dart';

import 'bloc/begining_bloc/bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AuthBlocObserver();
  runApp(BlocProvider<BeginingBloc>(
    create: (context) => BeginingBloc(),
    child: App(),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: "Note",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      routes: {
        'hp': (context) => HomePage(),
        'lp': (context) => LoginPage(),
        'ap': (context) => AddingNotePage(),
        'np': (context) => NotePage(),
        'fs': (context) => FirstScreen(),
        'nn': (context) => NicknamePage(),
        'sp': (context) => StartPage(),
      },
      home: BlocBuilder<BeginingBloc, BeginingState>(
        // bloc: BeginingBloc(),
        builder: (context, state) {
          if (state is BeginingInitial || state is BeginingLoading) {
            return SplashScreen();
          } else if (state is BeginingSucces) {
            return StartPage(
              colorIndex: state.colorIndex,
            );
          } else if (state is BeginingSuccesButEnered) {
            return NotePage(
              initialIndex: state.colorIndex,
            );
          } else if (state is BeginingFailure) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Container();
        },
      ),

      //else if (state is AuthenticationFailure) {
      //   return LoginPage(userRepository: widget._userRepository);
      // } else if (state is AuthenticationSuccess) {
      //   return LoginPage(
      //     userRepository: widget._userRepository,
      // );
      // }
    );
  }
}
