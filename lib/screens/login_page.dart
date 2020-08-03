import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_authentication/bloc.dart';
import 'package:note/bloc/bloc_login/bloc.dart';
import 'package:note/repository/user_repository.dart';
import 'package:note/screens/splash_screen.dart';
import 'package:note/widgets/login_form.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  final Color _color;
  // final UserRepository _userRepository;

  LoginPage({Key key, Color color})
      : assert(color != null),
        this._color = color,
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: widget._color),
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
              return _buildLogIn(new UserRepository());
            } else if (state is AuthenticationFailure) {
              return _buildFailure();
            } else if (state is AuthenticationSuccess) {}
          },
        ),
      ),
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

Widget _buildLogIn(UserRepository _userRepository) {
  return BlocProvider<LoginBloc>(
    create: (context) => LoginBloc(userRepository: _userRepository),
    child: LoginForm(userRepository: _userRepository),
  );
}
