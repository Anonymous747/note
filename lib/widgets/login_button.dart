import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final Color _color;

  LoginButton({Key key, VoidCallback onPressed, Color color})
      : _onPressed = onPressed,
        _color = color,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: RaisedButton(
        textColor: _color,
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: _onPressed,
        child: Text('Login'),
      ),
    );
  }
}
