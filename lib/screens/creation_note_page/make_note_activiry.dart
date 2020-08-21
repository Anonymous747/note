import 'package:flutter/material.dart';
import 'package:note/screens/creation_note_page/first_note_page.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/logo_widget.dart';

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

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    controller = PageController(initialPage: _currentIndex);
    positionLogo = Tween<double>(begin: 0.5, end: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            decoration: BoxDecoration(gradient: listColor[widget.colorIndex]),
            child: PageView(
              children: [
                FirstNotePage(),
              ],
            ),
          ),
          TweenAnimationBuilder(
              child: LogoWidget(),
              tween: positionLogo,
              duration: Duration(milliseconds: 500),
              builder: (context, animation, child) {
                return AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  top: _height * 0.1,
                  left: _currentIndex == null || _currentIndex == 0
                      ? _width / 2 - 50
                      : 15,
                  child: TweenAnimationBuilder(
                    child: LogoWidget(),
                    duration: Duration(milliseconds: 300),
                    tween: Tween(begin: 0, end: 0),
                    curve: Curves.elasticIn,
                    builder: (context, value, child) {
                      return Transform.scale(
                          scale: (animation - value) * 2, child: child);
                    },
                  ),
                );
              })
        ],
      ),
    );
  }
}
