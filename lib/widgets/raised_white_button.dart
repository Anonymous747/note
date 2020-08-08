import 'package:flutter/material.dart';

class RaisedWhiteButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final Color _textColor;
  final Text _text;
  final double _height;

  RaisedWhiteButton(
      {Key key,
      VoidCallback onPressed,
      Text text,
      double height,
      Color textColor})
      : _onPressed = onPressed,
        _textColor = textColor,
        _text = text,
        _height = height,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(0, 10), blurRadius: 15)
            ]),
        height: _height,
        child: RaisedButton(
          hoverColor: Colors.white,
          hoverElevation: 0,
          highlightColor: Colors.white,
          highlightElevation: 0,
          elevation: 0,
          textColor: _textColor,
          color: Colors.white,
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          onPressed: _onPressed,
          child: _text,
        ),
      ),
    );
  }
}
