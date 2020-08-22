import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note/startPages/color_page.dart';
import 'package:note/startPages/first_screen.dart';
import 'package:note/startPages/nickname_page.dart';
import 'package:note/utils/animation_item.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/alert_dialogs.dart';
import 'package:note/widgets/logo_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {
  final int colorIndex;

  StartPage({this.colorIndex});
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  PageController _pageController = PageController(initialPage: 0);
  List<AnimationItem> animationList = [];
  ValueNotifier pageNotifier;
  Tween<double> positionLogo;
  int _currentIndex;
  int _currentIndexColor;
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
    // _pageController = PageController(initialPage: 0);
    _currentIndexColor = widget.colorIndex ?? 0;
    positionLogo = Tween(begin: 0.0, end: 0.0);
    _animationColor = Tween(begin: 2.3, end: 2.3);
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: AlertDialogs(context).onBackPressed,
      child: Scaffold(
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
                        : LinearGradient(
                            colors: [Colors.white, Colors.white70])),
              ),
              builder: (BuildContext context, value, Widget child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              tween: _animationColor,
            ),
            SizedBox(
              height: _height,
              width: _width,
              child: PageView(
                physics: NeverScrollableScrollPhysics(parent: null),
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                    switch (index) {
                      case 0:
                        positionLogo = Tween(begin: 0.0, end: 0.0);
                        break;
                      default:
                        positionLogo = Tween(begin: 0.0, end: 0.25);
                    }
                  });
                  // });
                },
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  FirstScreen(
                    pageController: _pageController,
                    textColor: listColor[_currentIndexColor].colors[1],
                  ),
                  NicknamePage(),
                  ColorPage(
                    initialIndex: _currentIndexColor,
                    valueChanged: (index) {
                      setState(() {
                        _animationColor = Tween(begin: 4.0, end: 0.0);
                        _currentIndexColor = index;
                        _animationColor = Tween(begin: 0.0, end: 2.3);
                      });
                    },
                  ),
                ],
              ),
            ),
            TweenAnimationBuilder(
              child: LogoWidget(),
              duration: Duration(milliseconds: 500),
              tween: positionLogo,
              builder: (context, animation, child) {
                return AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  top: _height * 0.1,
                  left: _currentIndex == null || _currentIndex == 0
                      ? _width / 2 - (100 / 2)
                      : 15,
                  child: TweenAnimationBuilder(
                    child: LogoWidget(),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.elasticOut,
                    tween: findAnimation('logo_scale', 0.0, animationList),
                    builder: (context, value, child) {
                      return Transform.scale(
                          scale: value - animation, child: child);
                    },
                  ),
                );
              },
            ),
            AnimatedPositioned(
              top: _height * 0.85,
              right: _currentIndex == null || _currentIndex == 0 ? -40 : 10,
              width: 40,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              child: Column(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.expand_less,
                          color: _currentIndex != 1
                              ? Colors.white
                              : Colors.white54),
                      onPressed: () {
                        _pageController.animateToPage(_currentIndex - 1,
                            duration: Duration(milliseconds: 800),
                            curve: Curves.easeInCubic);
                      }),
                  SizedBox(
                    height: 0,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_more,
                      color: _currentIndex != 3 ? Colors.white : Colors.white54,
                    ),
                    onPressed: () {
                      _pageController.animateToPage(_currentIndex + 1,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInCubic);
                    },
                  )
                ],
              ),
            ),
            AnimatedPositioned(
                top: _height * 0.15,
                right: _currentIndex == null || _currentIndex == 0 ? -40 : 10,
                width: 40,
                duration: Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                child: Column(
                  children: <Widget>[
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == 1 ? Colors.white : Colors.white54,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == 2 ? Colors.white : Colors.white54,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == 3 ? Colors.white : Colors.white54,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
