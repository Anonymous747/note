import 'package:flutter/material.dart';
import 'package:note/widgets/texts/font_white_text.dart';

class NicknamePage extends StatefulWidget {
  @override
  _NicknamePageState createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  TextEditingController _nickController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
        top: _height * 0.23,
      ),
      child: Column(
        children: <Widget>[
          TitleWhiteText(
            text: "Nice to meet you! What do your friends call you?",
            align: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: _height * 0.22),
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // CustomTextField(
                  //     controller: _nickController,
                  //     helperText: 'your nickname'.toUpperCase(),
                  //     hintText: "Nickname",
                  //     minLines: 1,
                  //     maxLines: 1, ),
                  TextField(
                    controller: _nickController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        helperText: 'your nickname'.toUpperCase(),
                        helperStyle: TextStyle(color: Colors.white30),
                        counterStyle: TextStyle(color: Colors.white30),
                        hintText: "Nickname",
                        hintStyle:
                            TextStyle(fontSize: 20, color: Colors.white54)),
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: Colors.white),
                    maxLength: 32,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
