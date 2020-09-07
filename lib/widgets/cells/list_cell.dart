import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/cells/note_cell.dart';
import 'package:note/widgets/route_anim/fade_route.dart';

class ListCell extends StatelessWidget {
  final DateTime date;
  final String title;
  final String happened;
  final int percentFun;
  final int iconPreferences;
  final int emoji;
  final String randomQuestion;
  final String answer;
  final int index;

  ListCell({
    @required this.date,
    this.title,
    this.happened,
    this.percentFun,
    this.answer,
    this.emoji,
    this.iconPreferences,
    this.randomQuestion,
    this.index,
  });
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    Image image = Image.network(
      'https://picsum.photos/id/${index + 13}/${(0.8 * _width).round()}/${(0.65 * _height).round()}',
      fit: BoxFit.scaleDown,
    );
    NetworkImage netImage = image.image;
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(FadeRoute(
                    page: NoteCell(
                  title: title,
                  date: date,
                  happened: happened,
                  percentFun: percentFun,
                  answer: answer,
                  emoji: emoji,
                  iconPreferences: iconPreferences,
                  randomQuestion: randomQuestion,
                  image: netImage,
                  index: index,
                )));
              },
              child: Hero(tag: 'image${index}', child: image),
              // child: Image.network(
              //   'https://picsum.photos/id/${index + 11}/${(0.8 * _width).round()}/${(0.65 * _height).round()}',
              //   fit: BoxFit.fitWidth,
              // ),

              // child: Hero(
              //   transitionOnUserGestures: true,
              //   tag: 'hero-tag1',
              // child: Image(
              //   image: AssetImage(
              //     'assets/images/back1.jpg',
              //   ),
              //   fit: BoxFit.cover,
              //   width: _width,
              // ),
            )
            // )
            ),
        Padding(
            padding: EdgeInsets.only(
                top: _height * 0.05, left: _width * 0.06, right: _width * 0.06),
            child: Row(
              children: [
                Column(
                  children: [
                    Text('${date.day}',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${months[date.month - 1]}',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      '${date.year}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      CupertinoIcons.heart,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.only(bottom: _height * 0.05, left: _width * 0.05),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Hero(
                placeholderBuilder: (context, heroSize, child) => child,
                tag: 'text${index}',
                child: Text(
                  title ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              )),
        ),
        Positioned(
          bottom: _height * 0.02,
          child: Container(
            alignment: Alignment.topCenter,
            width: _width / 2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 20,
                    color: Colors.black,
                    offset: Offset(0, 5),
                    spreadRadius: 10),
              ],
            ),
          ),
        )
      ],
    );
  }
}
