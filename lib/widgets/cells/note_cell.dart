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
  final NetworkImage image;
  final int index;

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
    this.image,
    this.randomQuestion,
    this.index,
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
    int smile = (percentFun / 20).round();

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        overflow: Overflow.visible,
        children: [
          TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 500),
            tween: Tween(begin: 1.35, end: 1.35),
            builder: (context, value, child) => Transform.scale(
              scale: value,
              child: child,
            ),
            child: Hero(
              tag: 'image${index}',
              child: CircleAvatar(
                radius: radius,
                backgroundImage: image,
                // backgroundImage: AssetImage('assets/images/back1.jpg'),
              ),
            ),
          ),
          Positioned(
              top: _height * 0.5, right: -20, child: smiles[smile].smile),
          Padding(
            padding: EdgeInsets.only(
              top: radius * 2 + _height * 0.1,
              left: 40,
              right: 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'text${index}',
                  placeholderBuilder: (context, heroSize, child) => child,
                  child: Text(title,
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
                ),
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
                    IconWrap(
                      icon: icons[iconPreferences].icon,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconWrap(
                      icon: emojis[emoji].icon,
                      color: Colors.black54,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                answerText(happened),
                SizedBox(
                  height: 40,
                ),
                boldText(randomQuestion),
                SizedBox(
                  height: 20,
                ),
                answerText(answer),
                SizedBox(
                  height: 20,
                ),
                boldText('Your daily notes'),
                SizedBox(
                  height: 20,
                ),
                answerText('Edit story to add some text...'),
                SizedBox(
                  height: 60,
                ),
                boldText('Images of the day'),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Text boldText(String text) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
    );
  }

  Text answerText(String text) {
    return Text(text, style: TextStyle(fontSize: 15, color: Colors.black54));
  }
}
