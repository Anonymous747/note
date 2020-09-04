import 'package:flutter/material.dart';
import 'package:note/widgets/painting/line.dart';

class Arrow extends StatelessWidget {
  final Color color;

  Arrow({this.color});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Line(p1: Offset(0, -100), p2: Offset(0, -20), color: color, stroke: 8),
        Line(
            p1: Offset(0, -100), p2: Offset(-20, -80), color: color, stroke: 8),
        Line(p1: Offset(0, -100), p2: Offset(20, -80), color: color, stroke: 8),
      ],
    );
  }
}
