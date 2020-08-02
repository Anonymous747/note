import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_authentication/authentication_bloc.dart';
import 'package:note/bloc/bloc_authentication/bloc.dart';
import 'package:note/repository/remote_data_repository.dart';
import 'package:note/repository/user_repository.dart';
import 'package:note/screens/login_page.dart';
import 'package:note/widgets/animation/fade_animation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
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
    // Tween tween = new Tween(begin: 10.0, end: 180.0);
    // animation.addListener(() {
    //   setState(() {});
    // });
    // controller.forward();
    return Scaffold(
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
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: double.infinity,
                  ),
                ),
                // ),
                FadeAnimation(
                  2000,
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Hi there",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
                FadeAnimation(
                  3000,
                  Text("I'm Mirroring",
                      style: TextStyle(fontSize: 40, color: Colors.white)),
                ),
                FadeAnimation(
                  4000,
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      "Your new personal",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                FadeAnimation(
                  5000,
                  Text("journaling companion",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ],
            ),
          ),
          FadeAnimation(
            6000,
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                  child: RaisedButton(
                    padding: EdgeInsets.all(20.0),
                    textColor: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () {},
                    child: Text('Hi, Mirroring'.toUpperCase()),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: 30.0, left: 30.0, bottom: 20.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(0.0),
                    textColor: Colors.white,
                    color: color,
                    highlightColor: Color.fromRGBO(249, 161, 154, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context) {
                        return new BlocProvider<AuthenticationBloc>(
                          create: (context) => AuthenticationBloc()
                            ..add(AuthenticationStarted()),
                          child: LoginPage(color: color),
                        );
                      }));
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
    );
  }
}
