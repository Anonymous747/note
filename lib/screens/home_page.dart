import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/repository/remote_data_repository.dart';
import 'package:note/screens/goals_page.dart';
import 'package:note/screens/note_page.dart';
import 'package:note/widgets/alert_dialogs.dart';
import 'package:note/widgets/drawer.dart';
import 'package:note/widgets/route_anim/fade_route.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Future<bool> _onBackPressed() async {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text("Do you want to exit from the app?"),
  //       actions: <Widget>[
  //         FlatButton(
  //           child: Text("No"),
  //           onPressed: () => Navigator.pop(context, false),
  //         ),
  //         FlatButton(
  //           child: Text("Yes"),
  //           onPressed: () => Navigator.pop(context, true),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: AlertDialogs(context).onBackPressed,
      child: new Scaffold(
        appBar: new AppBar(),
        drawer: CustomDrawer(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text("Notes"),
              color: Colors.grey,
              onPressed: () async {
                FirebaseUser user1 = await auth.currentUser();
                if (user1 != null) {
                  return Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return BlocProvider<NoteBloc>(
                      create: (context) => NoteBloc(
                        repository: new RemDataRepImpl(),
                      ),
                      child: NotePage(user: user1),
                    );
                  }));
                }
              },
            ),
            MaterialButton(
              child: Text("Goals"),
              color: Colors.grey,
              onPressed: () {
                Navigator.of(context).push(FadeRoute(page: GoalsPage()));
              },
            ),
            MaterialButton(
              child: Text("History"),
              color: Colors.grey,
              onPressed: () {},
            ),
          ],
        )),
      ),
    );
  }
}
