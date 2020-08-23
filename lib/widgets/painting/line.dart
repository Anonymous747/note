import 'package:flutter/material.dart';
import 'package:note/widgets/painting/custom_line_painter.dart';

class Line extends StatelessWidget {
  final Offset p1;
  final Offset p2;

  Line({this.p1 = Offset.zero, this.p2 = Offset.zero});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: CustomLinePainter(p1: p1, p2: p2),
      ),
    );
  }
}
