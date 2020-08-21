import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/utils/consts.dart';
import 'package:note/screens/goals_page.dart';

class ListCell extends StatelessWidget {
  final DateTime date;
  final String title;

  ListCell({@required this.date, this.title});
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
                top: _height * 0.05, left: _width * 0.06, right: _width * 0.06),
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
                      '${months[date.month - 1]}',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      '${date.year}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      CupertinoIcons.heart,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.only(bottom: _height * 0.05, left: _width * 0.05),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )),
        )
      ],
    );
  }
}
