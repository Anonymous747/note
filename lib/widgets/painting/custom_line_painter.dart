import 'package:flutter/material.dart';

class CustomLinePainter extends CustomPainter {
  final Offset p1;
  final Offset p2;
  final Color color;
  final double stroke;

  CustomLinePainter(
      {@required this.p1,
      @required this.p2,
      this.color = Colors.white,
      this.stroke = 5});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
