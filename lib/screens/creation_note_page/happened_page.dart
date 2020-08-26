import 'package:flutter/material.dart';
import 'package:note/widgets/custom_text_field.dart';
import 'package:note/widgets/flat_transparent_button.dart';
import 'package:note/widgets/raised_white_button.dart';
import 'package:note/widgets/texts/font_white_text.dart';

class HappenedPage extends StatefulWidget {
  final Color textColor;
  final Function buttonFunction;

  HappenedPage({this.textColor, this.buttonFunction});

  @override
  _HappenedPageState createState() => _HappenedPageState();
}

class _HappenedPageState extends State<HappenedPage> {
  ValueNotifier<bool> textFieldNotifier;
  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textFieldNotifier = ValueNotifier<bool>(true);
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    // textFieldNotifier.value = false;
    return Padding(
      padding: EdgeInsets.only(top: _height * 0.2, left: 20, right: 20),
      child: Stack(
        children: [
          TitleWhiteText(
              text: 'Would you like to eleborate to  on what happened?'),
          ValueListenableBuilder(
            valueListenable: textFieldNotifier,
            builder: (_, truth, __) => AnimatedPositioned(
              bottom: truth ? _height * 0.3 : -240,
              // top: 0,
              left: _width * 0.2,
              duration: Duration(milliseconds: 400),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 150),
                opacity: truth ? 1 : 0,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RaisedWhiteButton(
                      width: _height * 0.25,
                      text: Text(
                        'YES!',
                      ),
                      textColor: widget.textColor ?? Colors.black54,
                      height: _height * 0.08,
                      onPressed: () {
                        textFieldNotifier.value = false;
                      },
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    // bottom: ,
                    FlatTransparentButton(
                      text: Text(
                        'No Thanks'.toUpperCase(),
                        style: TextStyle(color: Colors.white24),
                      ),
                      function: widget.buttonFunction,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: textFieldNotifier,
              builder: (_, truth, __) {
                return AnimatedPositioned(
                  top: truth ? _height : _height * 0.1,
                  // bottom: truth ? 240 : _height * 0.3,
                  duration: Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                      opacity: truth ? 0 : 1,
                      duration: Duration(milliseconds: 150),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints.loose(Size(_width, _height * 0.5)),
                        child: CustomTextField(
                          controller: textController,
                          hintText: 'Today was MOOD becouse...',
                          minLines: 10,
                        ),
                      )),
                );
              })
        ],
      ),
    );
  }
}
