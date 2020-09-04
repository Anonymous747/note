import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note/repository/user_repository.dart';
import 'package:note/screens/start_pages/start_exports.dart';
import 'package:note/widgets/route_anim/fade_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  UserRepository _repository = new UserRepository();
  FirebaseUser _currentUser;
  final int colorIndex;

  CustomDrawer({this.colorIndex}) {
    init();
  }

  init() async {
    _currentUser = await FirebaseAuth.instance.currentUser();
  }

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(widget._currentUser?.displayName ?? "MyName"),
          accountEmail: Text(widget._currentUser?.email ?? "MyEmail"),
          currentAccountPicture: CircleAvatar(
            backgroundColor:
                Theme.of(context).platform == TargetPlatform.android
                    ? Color(0x35cade)
                    : Color(0x2fe0b7),
            child: Text('Image'),
          ),
        ),
        ListTile(
            title: Text("Back"),
            trailing: Icon(Icons.arrow_back),
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            }),
        ListTile(
            title: Text("Log Out"),
            trailing: Icon(Icons.exit_to_app),
            onTap: () async {
              widget._repository.signOut();
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                  FadeRoute(
                      page: StartPage(
                    colorIndex: widget.colorIndex,
                  )),
                  ModalRoute.withName('sp'));
            }),
      ],
    ));
  }
}
