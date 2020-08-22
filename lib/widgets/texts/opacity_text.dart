import 'package:flutter/material.dart';

class OpacityText extends StatelessWidget {
  final String text;

  OpacityText({this.text});

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.05,
        child: Text(
          text ?? 'Empty text',
          style: TextStyle(
              fontSize: 60, letterSpacing: 2, fontWeight: FontWeight.bold),
        ));
  }
}
