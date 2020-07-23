import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note/repository/user_repository.dart';

class CustomDrawer extends StatelessWidget {
  final UserRepository _repository = new UserRepository();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        ListTile(
            title: Text("Back"),
            trailing: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }),
        ListTile(
            title: Text("Log Out"),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              _repository.signOut();
              Navigator.of(context).pop();
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
      ],
    ));
  }
}
