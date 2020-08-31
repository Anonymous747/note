import 'package:flutter/material.dart';
import 'package:note/model/smile_element.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/icon_wrap.dart';
import 'package:note/widgets/smiles/smile_export.dart';

class NoteCell extends StatelessWidget {
  final String title;
  final DateTime date;
  final int percentFun;
  final String happened;
  final int iconPreferences;
  final int emoji;
  final String randomQuestion;
  final String answer;

  Color smileColor;
  List<SmileElement> smiles;

  NoteCell({
    this.title = '',
    this.date,
    this.percentFun = 50,
    this.answer = '',
    this.emoji = 1,
    this.happened = '',
    this.iconPreferences,
    this.randomQuestion,
  }) {
    smileColor = Colors.black.withOpacity(0.05);

    smiles = [
      SmileElement(
          RealyTerribleSmile(
            smileColor: smileColor,
          ),
          'really terrible'),
      SmileElement(
          SomewhatBadSmile(
            smileColor: smileColor,
          ),
          'somewhat bad'),
      SmileElement(
          CompletelyOkaySmile(
            smileColor: smileColor,
          ),
          'completely okay'),
      SmileElement(
          PrettyGoodSmile(
            smileColor: smileColor,
          ),
          'pretty good'),
      SmileElement(
          SuperAwesomeSmile(
            smileColor: smileColor,
          ),
          'super awesome'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double radius = _width * 0.4;
    int smile = (1).round();

    return Scaffold(
        body: Stack(
      overflow: Overflow.visible,
      children: [
        TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 500),
            tween: Tween(begin: 1.35, end: 1.35),
            builder: (context, value, child) => Transform.scale(
                  // offset: Offset(-50, -50),
                  scale: value,
                  child: child,
                ),
            child: CircleAvatar(
              radius: radius,
              backgroundImage: AssetImage('assets/images/back1.jpg'),
            )),
        Positioned(top: _height * 0.5, right: -20, child: smiles[smile].smile),
        Padding(
          padding: EdgeInsets.only(
            top: radius * 2 + _height * 0.1,
            left: 40,
            right: 60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 10,
              ),
              Text(
                '${date.day}. ${months[date.month - 1]} ${date.year}',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black38, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconWrap(icon: Icon(Icons.ac_unit)),
                  SizedBox(
                    width: 10,
                  ),
                  IconWrap(icon: Icon(Icons.ac_unit)),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(happened ?? 'test',
                  style: TextStyle(color: Colors.amberAccent)),
            ],
          ),
        ),
      ],
    ));
  }
}
