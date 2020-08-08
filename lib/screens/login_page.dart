import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_authentication/bloc.dart';
import 'package:note/bloc/bloc_login/bloc.dart';
import 'package:note/repository/user_repository.dart';
import 'package:note/widgets/login_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:note/utils/consts.dart';

class LoginPage extends StatefulWidget {
  // final UserRepository _userRepository;
  LinearGradient gradient;

  LoginPage({Key key}) : super(key: key) {
    _initialize();
  }

  void _initialize() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int index = pref.getInt('color');
    gradient = listColor[index ?? 0];
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: widget.gradient),
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
