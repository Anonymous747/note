import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_authentication/bloc.dart';
import 'package:note/bloc/bloc_login/bloc.dart';
import 'package:note/repository/user_repository.dart';
import 'package:note/widgets/login_form.dart';
import 'package:note/utils/consts.dart';

class LoginPage extends StatefulWidget {
  // final UserRepository _userRepository;
  final int colorIndex;

  LoginPage({Key key, this.colorIndex}) : super(key: key) {
    // _initialize();
  }

  // void _initialize() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   int index = pref.getInt('color');
  //   gradient = listColor[index ?? 0];
  // }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        TweenAnimationBuilder(
            duration: Duration(milliseconds: 400),
            builder: (context, value, child) => Transform.scale(
                  scale: value,
                  child: child,
                ),
            tween: Tween(begin: 2.3, end: 2.3),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),

              // width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: listColor[widget.colorIndex],
              ),
            )),
        BlocProvider<AuthenticationBloc>.value(
          value: AuthenticationBloc(),
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationFailure) {
                return _buildFailure();
              }
            },
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              bloc: AuthenticationBloc(),
              builder: (context, state) {
                if (state is AuthenticationInitial) {
                  return _buildLogIn(widget.colorIndex);
                } else if (state is AuthenticationFailure) {
                  return _buildFailure();
                } else if (state is AuthenticationSuccess) {}
              },
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildFailure() {
  return Scaffold(
    body: Center(
      child: Text("Failure"),
    ),
  );
}

Widget _buildLogIn(int colorIndex) {
  return BlocProvider<LoginBloc>(
    create: (context) => LoginBloc(),
    child: LoginForm(colorIndex: colorIndex),
  );
}
