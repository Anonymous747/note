import 'package:flutter/material.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/change_color.dart';

class ColorPage extends StatefulWidget {
  final ValueChanged<int> valueChanged;
  final int initialIndex;
  ColorPage({Key key, this.valueChanged, this.initialIndex}) : super(key: key);

  @override
  _ColorPageState createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  PageController _pageController;
  double _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: widget.initialIndex ?? 0, viewportFraction: 0.3);
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.only(top: _height * 0.23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Themes, guest! Which one is most you?',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white54,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text('Can be changed latter in settings'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black12,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: PageView(
                  onPageChanged: (index) {
                    widget.valueChanged(index);
                  },
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  pageSnapping: true,
                  children: <Widget>[
                    ChangeColor(
                      onTap: () {
                        widget.valueChanged(_pageController.page.round());
                      },
                      offset: _currentIndex,
                      index: 0,
                      linearGradient: listColor[0],
                    ),
                    ChangeColor(
                      onTap: () {
                        widget.valueChanged(_pageController.page.round());
                      },
                      offset: _currentIndex,
                      index: 1,
                      linearGradient: listColor[1],
                    ),
                    ChangeColor(
                      onTap: () {
                        widget.valueChanged(_pageController.page.round());
                      },
                      offset: _currentIndex,
                      index: 2,
                      linearGradient: listColor[2],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 0.8),
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0, 10),
                                        blurRadius: 15)
                                  ],
                                ),
                                height: _height * 0.075,
                                child: RaisedButton(
                                  hoverColor: Colors.white,
                                  hoverElevation: 0,
                                  highlightColor: Colors.white,
                                  highlightElevation: 0,
                                  elevation: 0,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Text(
                                    'Next'.toUpperCase(),
                                    style: TextStyle(
                                        color: listColor[_currentIndex.round()]
                                            .colors[1]),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ))
          ],
        ));
  }
}
