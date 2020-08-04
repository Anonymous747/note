import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_authentication/authentication_bloc.dart';
import 'package:note/bloc/bloc_authentication/bloc.dart';
import 'package:note/repository/remote_data_repository.dart';
import 'package:note/repository/user_repository.dart';
import 'package:note/screens/login_page.dart';
import 'package:note/screens/nickname_page.dart';
import 'package:note/widgets/animation/fade_animation.dart';
import 'package:note/widgets/logo_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: new Duration(seconds: 4));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Color.fromRGBO(249, 161, 154, 1);

    Future<bool> _onBackPressed() async {
      return Alert(
          context: context,
          type: AlertType.none,
          title: "Are you sure?".toUpperCase(),
          style: AlertStyle(
              descStyle: TextStyle(fontSize: 15),
              titleStyle: TextStyle(color: Colors.red[300])),
          desc: "Are you certain that you want to close Mirroring?",
          buttons: [
            DialogButton(
              color: Colors.white,
              child: Icon(Icons.clear),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            DialogButton(
              color: Colors.white,
              child: Icon(Icons.check),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ]).show();
    }

    // Tween tween = new Tween(begin: 10.0, end: 180.0);
    // animation.addListener(() {
    //   setState(() {});
    // });
    // controller.forward();
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: color,
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // FadeAnimation(
                  //   1000,
                  Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: LogoWidget()),
                  // ),
                  FadeAnimation(
                    1000,
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Hi there",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    2000,
                    Text("I'm Mirroring",
                        style: TextStyle(fontSize: 40, color: Colors.white)),
                  ),
                  FadeAnimation(
                    3000,
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        "Your new personal",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    3000,
                    Text("journaling companion",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ],
              ),
            ),
            FadeAnimation(
              4000,
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                    child: RaisedButton(
                      padding: EdgeInsets.all(20.0),
                      textColor: color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.upToDown,
                                child: NicknamePage(
                                  color: color,
                                )));
                      },
                      child: Text('Hi, Mirroring'.toUpperCase()),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 30.0, left: 30.0, bottom: 20.0),
                    child: FlatButton(
                      padding: EdgeInsets.all(20),
                      textColor: Colors.white,
                      color: color,
                      highlightColor: Color.fromRGBO(249, 161, 154, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: BlocProvider<AuthenticationBloc>(
                              create: (context) => AuthenticationBloc()
                                ..add(AuthenticationStarted()),
                              child: LoginPage(color: color),
                            )));
                      },
                      child: Text(
                        'I already have an account'.toUpperCase(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
