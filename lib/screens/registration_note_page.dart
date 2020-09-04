import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note/model/element_note.dart';
import 'package:note/screens/creation_note_page/creation_extends.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/alert_dialogs.dart';
import 'package:note/widgets/arrow.dart';
import 'package:note/widgets/cells/add_cell.dart';
import 'package:note/widgets/cells/list_cell.dart';
import 'package:note/widgets/drawer.dart';
import 'package:note/widgets/route_anim/fade_route.dart';
import 'package:note/widgets/texts/opacity_text.dart';

class ResistrationNotePage extends StatefulWidget {
  final int initialIndex;
  final List<ElementNote> notes;

  ResistrationNotePage({this.initialIndex, this.notes});

  @override
  _ResistrationNotePageState createState() => _ResistrationNotePageState();
}

class _ResistrationNotePageState extends State<ResistrationNotePage> {
  PageController controller;
  final double viewportFraction = 0.7;
  double pageOffset;
  ValueNotifier<double> _pageNotifier;
  @override
  void initState() {
    super.initState();
    pageOffset = 0;
    controller = PageController(
        initialPage: pageOffset.round(), viewportFraction: viewportFraction);
    _pageNotifier = ValueNotifier<double>(pageOffset);
    controller.addListener(() {
      pageOffset = controller.page;
      _pageNotifier.value = controller.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildLoaded(widget.notes, 1);
  }

  Widget buildLoaded(List<ElementNote> list, int colorIndex) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    if (list == null) list = new List<ElementNote>();
    return WillPopScope(
      onWillPop: AlertDialogs(context).onBackPressed,
      child: Scaffold(
        drawer: CustomDrawer(
          colorIndex: widget.initialIndex,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: _width * 0.3,
                color: listColor[widget.initialIndex]
                    .colors
                    .last
                    .withOpacity(0.05),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _height * 0.17, left: 35),
              child: OpacityText(
                text: 'Your stories',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _height * 0.15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good evening,',
                                style: TextStyle(
                                    fontSize: 26, color: Colors.black26),
                              ),
                              Text('Name',
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: SizedBox(
                          width: double.infinity,
                          child: ValueListenableBuilder<double>(
                            valueListenable: _pageNotifier,
                            builder: (_, page, __) {
                              return PageView.builder(
                                  controller: controller,
                                  itemCount: list.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index + 10 >= page &&
                                        index - 10 <= page) {
                                      double scale = max(
                                          viewportFraction,
                                          (1 -
                                              (page - index).abs() +
                                              viewportFraction));
                                      if (list.length == 0) {
                                        return Container(
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(
                                              // left: page * 20,
                                              // right: _height * 0.03,
                                              top: 120 - scale * 35,
                                              bottom:
                                                  _height * 0.25 - scale * 15),
                                          child: AddCell(
                                              gradient: listColor[
                                                  widget.initialIndex],
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(FadeRoute(
                                                        page: MakeNoteActivity(
                                                  colorIndex:
                                                      widget.initialIndex,
                                                )));
                                              }),
                                        );
                                      } else {
                                        ElementNote currentElement =
                                            list[index];
                                        return Container(
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.only(
                                                right: _height * 0.05,
                                                top: 100 - scale * 35,
                                                bottom:
                                                    _height * 0.3 - scale * 15),
                                            child: ListCell(
                                              title: currentElement.title,
                                              date: currentElement.date,
                                              percentFun:
                                                  currentElement.percentFun,
                                              answer: currentElement.answer,
                                              emoji: currentElement.emoji,
                                              happened: currentElement.happened,
                                              iconPreferences: currentElement
                                                  .iconPreferences,
                                              randomQuestion:
                                                  currentElement.randomQuestion,
                                              index: index,
                                            ));
                                      }
                                    }
                                  });
                            },
                          ))),
                  // TweenAnimationBuilder<double>(
                  //     duration: Duration(microseconds: 400),
                  //     tween: Tween(begin: 0, end: 0),
                  //     builder: (context, value, child) {
                  //       return Transform.translate(
                  //         offset: Offset(0, value),
                  //         child: child,
                  //       );
                  //     },
                  //     child: Arrow(color: Colors.black.withOpacity(0.1))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
