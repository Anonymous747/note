import 'package:flutter/material.dart';

class FlatTransparentButton extends StatelessWidget {
  final Function _function;
  final Text _text;

  FlatTransparentButton({Function function, Text text})
      : _function = function,
        _text = text;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      highlightColor: Colors.transparent,
      onPressed: _function,
      child: _text,
      textColor: Colors.white,
      color: Colors.transparent,
    );
  }
}
