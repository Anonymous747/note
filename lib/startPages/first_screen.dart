import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/screens/login_page.dart';
import 'package:note/utils/animation_item.dart';
import 'package:note/widgets/animation/slide_right_animation.dart';
import 'package:note/widgets/flat_transparent_button.dart';
import 'package:note/widgets/logo_widget.dart';
import 'package:note/widgets/raised_white_button.dart';

class FirstScreen extends StatefulWidget {
  // final PageController _pageController;
  final Color textColor;
  final Function buttonFunction;
  final int colorIndex;

  FirstScreen({this.textColor, this.buttonFunction, this.colorIndex});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<AnimationItem> animationList = [];
  double _scaleHolder = 0;

  @override
  void initState() {
    super.initState();
    delayAnimation(
        AnimationItem(
            name: 'padding_top_lable',
            tween: Tween<double>(begin: 0.0, end: 1)),
        Duration(microseconds: 800), (animation) {
      animationList.add(animation);
    });
    delayAnimation(
        AnimationItem(
          name: 'button_scale',
          tween: Tween<double>(begin: 0.0, end: 0.9),
        ),
        Duration(milliseconds: 1200), (animation) {
      setState(() {
        animationList.add(animation);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Color.fromRGBO(249, 161, 154, 1);
    double _height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TweenAnimationBuilder(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            tween: findAnimation('padding_top_lable', 20, animationList),
            builder: (context, value, child) {
              return Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: _height * 0.24 + value),
                      child: AnimatedOpacity(
                          opacity: value == 20 ? 0 : 1,
                          duration: Duration(milliseconds: 700),
                          child: Text(
                            'Hi there,',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ))),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: AnimatedOpacity(
                          opacity: value == 20 ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            'I\'m Reflectly',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ))),
                  TweenAnimationBuilder(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      tween: findAnimation(
                        'padding_top_lable',
                        20,
                        animationList,
                      ),
                      builder: (context, value, child) {
                        return AnimatedOpacity(
                            opacity: value == 20 ? 0 : 1,
                            duration: Duration(milliseconds: 600),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 30, right: 30, top: 15 + value),
                                child: Text.rich(
                                  TextSpan(
                                    text: 'Your new personal\n',
                                    children: [
                                      TextSpan(text: 'journaling companion')
                                    ],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white54,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                )));
                      }),
                ],
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              children: <Widget>[
                TweenAnimationBuilder(
                  child: LogoWidget(),
                  duration: Duration(milliseconds: 800),
                  curve: Curves.elasticOut,
                  tween: _scaleHolder == 0.0
                      ? findAnimation('button_scale', 0.0, animationList)
                      : Tween(begin: 0.9, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.scale(
                        scale: value,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: RaisedWhiteButton(
                                    text: Text(
                                      'Hi, Reflectly'.toUpperCase(),
                                    ),
                                    textColor: widget.textColor,
                                    height: _height * 0.08,
                                    onPressed: widget.buttonFunction,
                                    // onPressed: () {
                                    // widget._pageController.animateToPage(1,
                                    //     duration: Duration(milliseconds: 800),
                                    //     curve: Curves.easeInCubic);
                                    // },
                                  ),
                                )
                              ],
                            )));
                  },
                ),
                TweenAnimationBuilder(
                  child: LogoWidget(),
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.elasticOut,
                  tween: findAnimation('button_scale', 0.0, animationList),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: FlatTransparentButton(
                        function: () {
                          Navigator.of(context).push(SlideRightAnimation(
                            child: LoginPage(colorIndex: widget.colorIndex),
                          ).buildRoute());
                        },
                        text: Text(
                          'I already have an account'.toUpperCase(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
