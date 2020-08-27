import 'package:flutter/material.dart';
import 'package:note/screens/creation_note_page/day_value_page.dart';
import 'package:note/screens/creation_note_page/first_note_page.dart';
import 'package:note/screens/creation_note_page/happened_page.dart';
import 'package:note/screens/creation_note_page/mood_page.dart';
import 'package:note/screens/creation_note_page/random_question_page.dart';
import 'package:note/screens/creation_note_page/smile_page.dart';
import 'package:note/screens/creation_note_page/title_page.dart';
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
  ValueNotifier<double> logoNotifier;
  bool isLogoStartState;
  List<Widget> pages;

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
    Color currentColor = listColor[widget.colorIndex].colors.last;
    pages = [
      FirstNotePage(
        index: widget.colorIndex,
        buttonFunction: transitionFunction,
      ),
      MoodPage(
        sliderFunction: transitionFunction,
      ),
      DayValuePage(
        buttonFunction: transitionFunction,
      ),
      HappenedPage(
        textColor: currentColor,
        buttonFunction: transitionFunction,
      ),
      SmilePage(
        buttonFunction: transitionFunction,
      ),
      RandomQuestionPage(
        buttonFunction: transitionFunction,
        textColor: currentColor,
      ),
      TitlePage(
        textColor: currentColor,
      )
    ];
  }

  void transitionFunction() {
    if (controller.page == 0) isLogoStartState = false;
    if (controller.page == pages.length - 2) isLogoStartState = true;
    controller.animateToPage(_currentIndex + 1,
        duration: Duration(milliseconds: 1000), curve: Curves.easeInExpo);
  }

  Future<bool> onBackPressed() async {
    if (controller.page != 0) {
      if (controller.page == pages.length - 1) isLogoStartState = false;
      if (controller.page == 1) isLogoStartState = true;
      controller.animateToPage(_currentIndex - 1,
          duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
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
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(parent: null),
                scrollDirection: Axis.vertical,
                controller: controller,
                itemCount: pages.length,
                itemBuilder: (context, index) => pages[index],
                // children: [
                //   FirstNotePage(
                //     index: widget.colorIndex,
                //     buttonFunction: transitionFunction,
                //   ),
                //   MoodPage(
                //     sliderFunction: transitionFunction,
                //   ),
                //   DayValuePage(
                //     buttonFunction: transitionFunction,
                //   ),
                //   HappenedPage(
                //     textColor: listColor[widget.colorIndex].colors.last,
                //     buttonFunction: transitionFunction,
                //   ),
                //   SmilePage(
                //     buttonFunction: transitionFunction,
                //   ),
                //   RandomQuestionPage(
                //     buttonFunction: transitionFunction,
                //     textColor: listColor[widget.colorIndex].colors.last,
                //   ),
                //   TitlePage()
                // ],
              ),
            ),
            TweenAnimationBuilder<double>(
                child: LogoWidget(),
                tween: Tween(begin: 0, end: 0.9),
                duration: Duration(milliseconds: 500),
                builder: (context, animation, child) {
                  return ValueListenableBuilder<double>(
                    valueListenable: logoNotifier,
                    builder: (context, value, child) {
                      return AnimatedPositioned(
                        duration: Duration(milliseconds: 700),
                        child: TweenAnimationBuilder<double>(
                          duration: Duration(
                            milliseconds: 700,
                          ),
                          child: LogoWidget(),
                          tween: isLogoStartState
                              ? Tween(begin: 0, end: 0)
                              : Tween(begin: 0, end: 0.3),
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: animation - value,
                              child: child,
                            );
                          },
                        ),
                        top: isLogoStartState ? _height * 0.15 : _height * 0.05,
                        left: isLogoStartState ? _width / 2 - 50 : 0,
                      );
                    },
                  );
                }),
            ValueListenableBuilder(
                valueListenable: logoNotifier,
                builder: (_, page, __) {
                  return AnimatedPositioned(
                    top: _height * 0.85,
                    right: isLogoStartState ? -40 : 10,
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
                          onPressed: onBackPressed,
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.expand_more,
                            color: _currentIndex != 3
                                ? Colors.white
                                : Colors.white54,
                          ),
                          onPressed: transitionFunction,
                        )
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
