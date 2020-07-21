import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/repository/user_repository.dart';
import 'package:note/screens/note_page.dart';

class HomePage extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  // HomePage({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MaterialButton(
          child: Text("Notes"),
          color: Colors.grey,
          onPressed: () async {
            FirebaseUser user = await auth.currentUser();
            // if (user != null) {
            // return Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) {
            //   return BlocProvider<NoteBloc>(
            //     create: (context) => NoteBloc(
            //       repository: new UserRepImpl(user: (user)),
            //     ),
            //     child: NotePage(),
            //   );
            // }));
            // }
          },
        ),
        MaterialButton(
          child: Text("Goals"),
          color: Colors.grey,
          onPressed: () {},
        ),
        MaterialButton(
          child: Text("History"),
          color: Colors.grey,
          onPressed: () {},
        ),
      ],
    ));
  }

  // Future<FirebaseUser> _signInAnonymously() async {
  //   final user = await auth.signInAnonymously();
  //   return user;
  // }

  Future<FirebaseUser> _signInSomeAccount() async {
    final res = await auth.createUserWithEmailAndPassword(
        email: "email@mail.ru", password: "1111111");
    return res.user;
  }

  Future<FirebaseUser> _signInAccount() async {
    final res = await auth.signInWithEmailAndPassword(
        email: "email@mail.ru", password: "1111111");
    return res.user;
  }
}
