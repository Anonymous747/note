import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_login/bloc.dart';

class GoogleLoginButton extends StatelessWidget {
  final Color _color;

  GoogleLoginButton({@required Color color})
      : assert(color != null),
        _color = color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () {
          BlocProvider.of<LoginBloc>(context).add(
            LoginWithGooglePressed(),
          );
        },
        child:
            Text('Sign in with Google', style: TextStyle(color: Colors.white)),
        color: _color,
      ),
    );
  }
}
