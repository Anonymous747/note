import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/cells/note_cell.dart';
import 'package:note/widgets/route_anim/fade_route.dart';

class RegistrNoteCell extends StatelessWidget {
  final DateTime date;
  final String title;
  final int percentFun;

  RegistrNoteCell({
    @required this.date,
    this.title,
    this.percentFun,
  });
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    Image image = Image(
      height: 1200,
      width: 800,
      image: AssetImage('assets/images/back1.jpg'),
      fit: BoxFit.fitWidth,
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          borderRadius: BorderRadius.circular(30),
          child: image,
        ),
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
            ),
          ),
        ),
        Positioned(
          bottom: _height * 0.02,
          child: Container(
            alignment: Alignment.topCenter,
            width: _width / 2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 20,
                    color: Colors.black,
                    offset: Offset(0, 5),
                    spreadRadius: 10),
              ],
            ),
          ),
        )
      ],
    );
  }
}
