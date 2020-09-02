import 'package:flutter/material.dart';
import 'package:note/utils/consts.dart';

class AddCell extends StatelessWidget {
  final Gradient gradient;
  final Function onTap;
  final Function onLongPress;

  AddCell({this.gradient, this.onTap, this.onLongPress});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Hero(
        tag: 'gradient0',
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: gradient ?? listColor[0],
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.border_color,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Add today\'s story'.toUpperCase(),
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
