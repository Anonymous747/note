import 'package:flutter/material.dart';

class CustomLinePainter extends CustomPainter {
  final Offset p1;
  final Offset p2;

  CustomLinePainter({@required this.p1, @required this.p2});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
