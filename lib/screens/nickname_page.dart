import 'package:flutter/material.dart';
import 'package:note/widgets/texts/font_white_text.dart';

class NicknamePage extends StatefulWidget {
  @override
  _NicknamePageState createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  TextEditingController _nickController = new TextEditingController();
  String _nickname = '';
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        _nickname = text;
                      });
                    },
                    smartQuotesType: SmartQuotesType.enabled,
                    controller: _nickController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: "",
                        hintText: "Nickname",
                        hintStyle:
                            TextStyle(fontSize: 20, color: Colors.white54)),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    autocorrect: false,
                    maxLength: 32,
                    maxLengthEnforced: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'your nickname'.toUpperCase(),
                        style: TextStyle(color: Colors.white30),
                      ),
                      Text('${_nickname.length} / 32',
                          style: TextStyle(color: Colors.white30)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
