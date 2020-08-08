import 'package:flutter/material.dart';

class SlideRightAnimation {
  final Widget _child;

  SlideRightAnimation({Widget child}) : _child = child;

  Route buildRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => _child,
      transitionDuration: Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Curve curve = Curves.ease;
        var tween = Tween(begin: Offset(1, 0), end: Offset.zero)
            .chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
