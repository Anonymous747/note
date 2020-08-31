import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_creation/bloc.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/custom_text_field.dart';
import 'package:note/widgets/flat_transparent_button.dart';
import 'package:note/widgets/raised_white_button.dart';
import 'package:note/widgets/texts/font_white_text.dart';

class RandomQuestionPage extends StatefulWidget {
  final Color textColor;
  final Function buttonFunction;

  RandomQuestionPage({this.textColor, this.buttonFunction});

  @override
  _RandomQuestionPageState createState() => _RandomQuestionPageState();
}

class _RandomQuestionPageState extends State<RandomQuestionPage> {
  ValueNotifier<bool> textFieldNotifier;
  TextEditingController textController;

  // List<String> questions = [
  //   'Some question',
  //   'What\'s the craziest thing you\'ve ever done?',
  //   'fdfd',
  // ];

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
    Random number = Random();
    // textFieldNotifier.value = false;
    String question = questions[number.nextInt(questions.length)];
    return Padding(
      padding: EdgeInsets.only(top: _height * 0.2, left: 20, right: 20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleWhiteText(text: question),
              SizedBox(
                height: 15,
              ),
              Text(
                'Question of the day -'.toUpperCase(),
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, color: Colors.black26),
              )
            ],
          ),
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
                        'WELL ..',
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
                      function: () {
                        BlocProvider.of<CreationBloc>(context).add(
                            CreationRandomQuestionChanged(
                                randomQuestion: question, answer: ''));
                        widget.buttonFunction();
                      },
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
                  top: truth ? _height : _height * 0.15,
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
                          hintText: 'Hmm, well...',
                          minLines: 20,
                          onEditingComplete: () {
                            BlocProvider.of<CreationBloc>(context).add(
                                CreationRandomQuestionChanged(
                                    randomQuestion: question,
                                    answer: textController.text));
                            widget.buttonFunction();
                          },
                        ),
                      )),
                );
              })
        ],
      ),
    );
  }
}
