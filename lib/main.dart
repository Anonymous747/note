import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note/repository/user_repository.dart';
import 'package:note/screens/home_page.dart';
import 'package:note/screens/note_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> _signInAnonymously() async {
  FirebaseUser user = await _auth.signInAnonymously();
  return user;
}

Future<FirebaseUser> _signInAccount() async {
  final user = await _auth.signInWithEmailAndPassword(
      email: "email@mail.ru", password: "1111111");
  return user;
}

FirebaseUser _currentUser;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _currentUser = await _signInAccount();

  runApp(new App());
}

class App extends StatelessWidget {
  // UserRep repository;

  //App() {
  //this.repository = new UserRepImpl(user: _currentUser);
  //}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Note",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      routes: {
        '/': (context) => HomePage(
            // user: _currentUser,
            ),
        'note': (context) => NotePage(),
      },
      initialRoute: '/',
    );
  }
}
