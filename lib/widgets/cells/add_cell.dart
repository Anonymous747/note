import 'package:flutter/material.dart';
import 'package:note/utils/consts.dart';

class AddCell extends StatelessWidget {
  final Gradient gradient;
  final Function onTap;
  final Function onLongPress;

  AddCell({this.gradient, this.onTap, this.onLongPress});
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Hero(
        tag: 'gradient0',
        child: Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              gradient: gradient ?? listColor[0],
              borderRadius: BorderRadius.circular(30)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 80),
                child: Icon(
                  Icons.border_color,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Text('Add today\'s story'.toUpperCase(),
                    style: TextStyle(color: Colors.white.withOpacity(0.7))),
              ),
              Positioned(
                bottom: _height * 0.02,
                child: Container(
                  width: _width / 2,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 25,
                          color: gradient.colors.last,
                          offset: Offset(0, 15),
                          spreadRadius: 10),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
