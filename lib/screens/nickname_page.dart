import 'package:flutter/material.dart';
import 'package:note/widgets/logo_widget.dart';

class NicknamePage extends StatefulWidget {
  // final Color _color;

  // NicknamePage({Color color})
  //     : assert(color != null),
  //       this._color = color;

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
          Text(
            "Nice to meet you! What do your friends call you?",
            style: TextStyle(color: Colors.white70, fontSize: 25.0),
            textAlign: TextAlign.center,
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
                        // counter: Text('${_nickController.text.length} / 32'),
                        hintText: "Nickname",
                        hintStyle:
                            TextStyle(fontSize: 20, color: Colors.white54)),
                    // onEditingComplete: () =>,
                    onEditingComplete: () {},
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

      // child: Scaffold(
      //     // decoration: BoxDecoration(
      //     //   color: widget._color,
      //     // ),
      //     // backgroundColor: widget._color,
      //     body: Padding(
      //   padding: const EdgeInsets.only(
      //       right: 30.0, left: 30.0, top: 20.0, bottom: 20.0),
      //   child: Stack(
      //     // crossAxisAlignment: CrossAxisAlignment.center,
      //     // mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       ListView(
      //         children: <Widget>[
      //           Row(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: <Widget>[LogoWidget()],
      //           ),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           Text(
      //             "Nice to meet you! What do your friends call you?",
      //             style: TextStyle(color: Colors.white70, fontSize: 25.0),
      //           )
      //         ],
      //       ),
      //       Align(
      //         alignment: Alignment.center,
      //         child: TextField(
      //           smartQuotesType: SmartQuotesType.enabled,
      //           controller: _nickController,
      //           decoration: InputDecoration(
      //               border: InputBorder.none,
      //               hintText: "Email",
      //               hintStyle: TextStyle(fontSize: 20, color: Colors.white54)),
      //           // onEditingComplete: () =>,
      //           keyboardType: TextInputType.emailAddress,
      //           style: TextStyle(color: Colors.white),
      //           autocorrect: false,
      //           maxLength: 32,
      //         ),
      //       ),
      //     ],
      //   ),
      // )),
    );
  }
}

//   ),
// )),
