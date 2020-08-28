import 'package:flutter/material.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/raised_white_button.dart';
import 'package:note/widgets/texts/font_white_text.dart';
import 'package:note/widgets/texts/opacity_text.dart';

class FirstNotePage extends StatefulWidget {
  final int colorIndex;
  final Function buttonFunction;

  FirstNotePage({this.colorIndex, @required this.buttonFunction});

  @override
  _FirstNotePageState createState() => _FirstNotePageState();
}

class _FirstNotePageState extends State<FirstNotePage> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              right: _width * 0.1, left: _width * 0.1, top: _height * 0.3),
          child: TitleWhiteText(
            text: 'Good evening Name, ready to create a new story?',
            align: TextAlign.center,
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: _height * 0.15),
              child: OpacityText(text: 'Story Date'),
            )),
        Padding(
          padding: EdgeInsets.only(top: _height * 0.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                fullMonths[DateTime.now().month - 1] + ' ${DateTime.now().day}',
                style: TextStyle(fontSize: 25, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Today'.toUpperCase(),
                style: TextStyle(color: Colors.white24, fontSize: 15),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: RaisedWhiteButton(
                text: Text(
                  'Let\'s do it'.toUpperCase(),
                ),
                textColor: listColor[widget.colorIndex ?? 0].colors.last,
                onPressed: widget.buttonFunction,
                height: _height * 0.08,
              ),
            ))
      ],
    );
  }
}
