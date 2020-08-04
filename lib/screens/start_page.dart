import 'package:flutter/material.dart';
import 'package:note/utils/animation_item.dart';
import 'package:note/utils/consts.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  PageController _pageController;
  List<AnimationItem> animationList = [];
  Tween<double> positionLoge;
  int _currentIndex;
  int _currentIndexColor = 0;
  Tween _animationColor;
  @override
  void initState() {
    super.initState();
    setState(() {});
    delayAnimation(
        AnimationItem(
          name: 'logo_scale',
          tween: Tween<double>(begin: 0.0, end: 0.8),
        ),
        Duration(microseconds: 800), (animation) {
      setState(() {
        animationList.add(animation);
      });
    });
    _pageController = PageController(initialPage: 0);
    positionLoge = Tween(begin: 0.0, end: 0.0);
    _animationColor = Tween(begin: 2.3, end: 2.3);
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          TweenAnimationBuilder(
            duration: Duration(milliseconds: 400),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: _currentIndexColor != null
                      ? listColor[_currentIndexColor]
                      : null),
            ),
            builder: (BuildContext context, value, Widget child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            tween: _animationColor,
          ),
        ],
      ),
    );
  }
}
