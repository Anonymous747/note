import 'package:flutter/material.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Hero(
        tag: 'hero-tag1',
        child: Image(
          image: AssetImage(
            'assets/images/back1.jpg',
          ),
          width: 100,
        ),
      ),
    );
  }
}
