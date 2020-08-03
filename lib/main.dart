import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_authentication/authentication_observer.dart';
import 'package:note/repository/remote_data_repository.dart';
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
  // Flame.images.loadAll(<String>[
  //   'images/logo.png',
  // ]);
  // ImageCache().clear();

  // _currentUser = (await _signInAccount()).user;
  runApp(new App());
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
      theme: ThemeData(primarySwatch: Colors.amber),
      routes: {
        'hp': (context) => HomePage(),
        'lp': (context) => LoginPage(),
        'ap': (context) => AddingNotePage(),
        'np': (context) => NotePage(),
        'ss': (context) => SplashScreen(),
      },
      home: SplashScreen(),

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
