import 'package:flutter/material.dart';

class IconWrap extends StatelessWidget {
  final Icon icon;

  IconWrap({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10)),
      child: Center(child: icon),
    );
  }
}
