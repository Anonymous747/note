import 'package:flutter/material.dart';
import 'package:note/widgets/custom_text_field.dart';
import 'package:note/widgets/flat_transparent_button.dart';
import 'package:note/widgets/raised_white_button.dart';
import 'package:note/widgets/texts/font_white_text.dart';

class TitlePage extends StatefulWidget {
  final Color textColor;

  TitlePage({this.textColor});

  @override
  _TitlePageState createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Padding(
      padding:
          EdgeInsets.only(top: _height * 0.3, right: 20, left: 20, bottom: 20),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleWhiteText(
            text:
                'Marvelous job - another day, another story! What would be a good title for it?',
            align: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: _height * 0.2),
            child: CustomTextField(
              hintText: 'Add title ...',
              helperText: 'story title',
            ),
          ),
          Positioned.fill(
            top: _height * 0.5,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedWhiteButton(
                  text: Text('Save story'.toUpperCase()),
                  height: 0.08 * _height,
                  textColor: widget.textColor,
                  onPressed: () {},
                ),
                FlatTransparentButton(
                  text: Text('Wait, i forgot something!'.toUpperCase()),
                  function: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
