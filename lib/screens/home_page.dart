import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/repository/remote_data_repository.dart';
import 'package:note/screens/goals_page.dart';
import 'package:note/screens/note_page.dart';
import 'package:note/widgets/drawer.dart';
import 'package:note/widgets/route_anim/fade_route.dart';

class HomePage extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
    );
  }
}
