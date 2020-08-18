import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/screens/goals_page.dart';

class ListCell extends StatelessWidget {
  final String text;
  final DateTime date;

  ListCell({this.text, @required this.date});
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Hero(
              transitionOnUserGestures: true,
              tag: 'hero-tag1',
              child: Image(
                image: AssetImage(
                  'assets/images/back1.jpg',
                ),
                fit: BoxFit.cover,
                width: _width,
              ),
            )),
        Padding(
            padding: EdgeInsets.only(
                top: _height * 0.05, left: _width * 0.05, right: _width * 0.05),
            child: Row(
              children: [
                Column(
                  children: [
                    Text('${date.day}',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${date.month}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${date.year}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Icon(
                  CupertinoIcons.heart,
                  color: Colors.white,
                ),
              ],
            ))
      ],
    );
  }
}
