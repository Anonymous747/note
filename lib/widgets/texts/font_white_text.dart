import 'package:flutter/material.dart';

class TitleWhiteText extends StatelessWidget {
  final String text;
  final TextAlign align;

  TitleWhiteText({this.text, this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.white70, fontSize: 25.0),
      textAlign: align ?? TextAlign.start,
    );
  }
}
