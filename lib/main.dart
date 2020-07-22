import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_authentication/authentication_bloc.dart';
import 'package:note/bloc/bloc_authentication/authentication_observer.dart';
import 'package:note/bloc/bloc_authentication/bloc.dart';
import 'package:note/repository/user_repository.dart';
import 'package:note/screens/add_note_page.dart';
import 'package:note/screens/home_page.dart';
import 'package:note/screens/login_page.dart';
import 'package:note/screens/note_page.dart';
import 'package:note/screens/splash_screen.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;

// Future<AuthResult> _signInAccount() async {
//   final user = await _auth.signInWithEmailAndPassword(
//       email: "email@mail.ru", password: "1111111");
//   return user;
// }

// FirebaseUser _currentUser;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AuthBlocObserver();
  final UserRepository userRepository = UserRepository();

  // _currentUser = (await _signInAccount()).user;
  runApp(
    new BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AuthenticationStarted()),
      child: App(
        userRepository: userRepository,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Note",
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        routes: {
          'hp': (context) => HomePage(),
          'lp': (context) => LoginPage(
                userRepository: _userRepository,
              ),
          'ap': (context) => AddingNotePage(),
          'np': (context) => NotePage(),
        },
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is AuthenticationInitial) {
            return SplashScreen();
          } else if (state is AuthenticationFailure) {
            return LoginPage(userRepository: _userRepository);
          } else if (state is AuthenticationSuccess) {
            return LoginPage(
              userRepository: _userRepository,
            );
          }
          return Container();
        }));
  }
}
