import 'package:flutter/material.dart';

class ListCell extends StatelessWidget {
  final String text;

  ListCell({this.text});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image(
              image: AssetImage(
                'assets/images/back1.jpg',
              ),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            )),
      ],
    );
  }
}
