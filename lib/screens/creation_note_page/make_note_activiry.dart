import 'package:flutter/material.dart';
import 'package:note/screens/creation_note_page/first_note_page.dart';
import 'package:note/screens/creation_note_page/mood_page.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/alert_dialogs.dart';
import 'package:note/widgets/logo_widget.dart';
import 'package:note/widgets/texts/font_white_text.dart';

class MakeNoteActivity extends StatefulWidget {
  final int colorIndex;

  MakeNoteActivity({this.colorIndex});

  @override
  _MakeNoteActivityState createState() => _MakeNoteActivityState();
}

class _MakeNoteActivityState extends State<MakeNoteActivity> {
  PageController controller;
  int _currentIndex;
  Tween<double> positionLogo;
  ValueNotifier logoNotifier;
  bool isLogoStartState;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    controller = PageController(initialPage: _currentIndex);
    logoNotifier = ValueNotifier<double>(0);
    positionLogo = Tween<double>(begin: 0.0, end: 0.0);
    isLogoStartState = true;

    controller.addListener(() {
      _currentIndex = controller.page.round();
      logoNotifier.value = controller.page;
    });
  }

  void transitionFunction() {
    if (controller.page == 0) isLogoStartState = false;
    controller.animateToPage(_currentIndex + 1,
        duration: Duration(milliseconds: 500), curve: Curves.easeInExpo);
  }

  Future<bool> onBackPressed() async {
    if (controller.page != 0) {
      if (controller.page == 1) isLogoStartState = true;
      controller.animateToPage(_currentIndex - 1,
          duration: Duration(milliseconds: 700), curve: Curves.easeInOut);
      // return true;
    } else {
      AlertDialogs(context).onBackPressedInCreatingNote();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(gradient: listColor[widget.colorIndex]),
              child: PageView(
                physics: NeverScrollableScrollPhysics(parent: null),
                controller: controller,
                children: [
                  FirstNotePage(
                    index: widget.colorIndex,
                    buttonFunction: transitionFunction,
                  ),
                  MoodPage(),
                ],
              ),
            ),
            TweenAnimationBuilder<double>(
                child: LogoWidget(),
                tween: Tween(begin: 0, end: 0.9),
                duration: Duration(milliseconds: 500),
                builder: (context, animation, child) {
                  return ValueListenableBuilder(
                    valueListenable: logoNotifier,
                    builder: (context, value, child) {
                      if (!isLogoStartState) {
                        return AnimatedPositioned(
                          duration: Duration(milliseconds: 700),
                          child: TweenAnimationBuilder(
                            duration: Duration(
                              milliseconds: 700,
                            ),
                            child: LogoWidget(),
                            tween: Tween(begin: 0, end: 0.3),
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: animation - value,
                                child: child,
                              );
                            },
                          ),
                          top: _height * 0.05,
                          left: 0,
                        );
                      } else
                        return child;
                    },
                    child: AnimatedPositioned(
                      duration: Duration(milliseconds: 600),
                      top: _height * 0.15,
                      left: _width / 2 - 50,
                      child: TweenAnimationBuilder(
                        child: LogoWidget(),
                        duration: Duration(milliseconds: 600),
                        tween: Tween(begin: 0.3, end: 0),
                        // curve: Curves.elasticIn,
                        builder: (context, value, child) {
                          return Transform.scale(
                              scale: animation - value, child: child);
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
