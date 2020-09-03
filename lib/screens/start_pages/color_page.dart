import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_register/bloc.dart';
import 'package:note/screens/registration_note_page.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/change_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorPage extends StatefulWidget {
  final ValueChanged<int> valueChanged;
  final int initialIndex;
  ColorPage({Key key, this.valueChanged, this.initialIndex}) : super(key: key);

  @override
  _ColorPageState createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  PageController _pageController;
  double _currentIndex;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.roundToDouble();
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
                child: PageView.builder(
                  onPageChanged: (index) {
                    widget.valueChanged(index);
                  },
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  pageSnapping: true,
                  itemCount: listColor.length,
                  itemBuilder: (context, index) => ChangeColor(
                    onTap: () {
                      widget.valueChanged(_pageController.page.round());
                    },
                    offset: _currentIndex,
                    index: index,
                    linearGradient: listColor[index],
                  ),
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
                                  onPressed: _onNotePage,
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

  void _onNotePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('color', _currentIndex.round());
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(),
            child: ResistrationNotePage(
              initialIndex: widget.initialIndex,
            ),
          ),
        ),
        ModalRoute.withName('rnp'));
  }
}
