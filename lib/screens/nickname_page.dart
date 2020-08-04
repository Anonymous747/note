import 'package:flutter/material.dart';
import 'package:note/widgets/logo_widget.dart';

class NicknamePage extends StatefulWidget {
  final Color _color;

  NicknamePage({Color color})
      : assert(color != null),
        this._color = color;

  @override
  _NicknamePageState createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  TextEditingController _nickController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: widget._color,
          ),
          // backgroundColor: widget._color,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 30.0, left: 30.0, top: 20.0, bottom: 20.0),
            child: Stack(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[LogoWidget()],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Nice to meet you! What do your friends call you?",
                      style: TextStyle(color: Colors.white70, fontSize: 25.0),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextField(
                    smartQuotesType: SmartQuotesType.enabled,
                    controller: _nickController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle:
                            TextStyle(fontSize: 20, color: Colors.white54)),
                    // onEditingComplete: () =>,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    autocorrect: false,
                    maxLength: 32,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
