import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/screens/creation_note_page/creation_extends.dart';
import 'package:note/widgets/cells/add_cell.dart';
import 'package:note/widgets/drawer.dart';
import 'package:note/widgets/cells/list_cell.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/route_anim/fade_route.dart';

class NotePage extends StatefulWidget {
  final int initialIndex;
  final List<ElementNote> notes;

  NotePage({this.initialIndex, this.notes});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  PageController controller;
  // NoteBloc bloc;
  final double viewportFraction = 0.8;
  double pageOffset;
  ValueNotifier<double> _pageNotifier;
  // final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    // bloc = BlocProvider.of<NoteBloc>(context);
    // bloc.add(FetchNotes());
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

  // Widget buidLoading() {
  //   return Center(
  //     child: CircularProgressIndicator(),
  //   );
  // }

  Widget buildLoaded(List<ElementNote> list, int colorIndex) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    if (list == null) list = new List<ElementNote>();
    // ModalBottomSheets(context).buildIntermediateSheet(
    //   title: 'I\'m so excited to start this journey with you, Name!',
    //   firstSubTitle:
    //       'Let\'s get your great new habit rolling by\ncreating your first story together!',
    //   secSubTitle:
    //       'Get started by clicking the \"Add Story\" card,\nand I\'ll guide you through the process.',
    //   isSubTitleBold: true,
    //   buttonText: 'Write on!',
    //   buttonFunc: () {
    //     Navigator.of(context).pop(false);
    //     print('ok' );
    //   },
    //   colorIndex: colorIndex,
    // );
    return Scaffold(
      body: Stack(
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedItemColor: Colors.black,
        //   selectedFontSize: 10,
        //   showUnselectedLabels: false,
        //   selectedLabelStyle: TextStyle(
        //       fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black),
        //   unselectedItemColor: Colors.black26,
        //   iconSize: 30,
        //   currentIndex: 0,
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: Icon(CupertinoIcons.pencil), title: Text('●')),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.assessment), title: Text('●')),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.person_outline), title: Text('●')),
        //   ],
        // ),
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: _width * 0.2,
              color: Colors.black12,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: _height * 0.07),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: _height * 0.04),
                        icon: Icon(Icons.settings, size: 30),
                        onPressed: () {})
                  ],
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
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
                    IconButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: _height * 0.04),
                        icon: Icon(
                          Icons.add,
                          size: 30,
                        ),
                        onPressed: () {})
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
                            if (index + 2 >= page && index - 2 <= page) {
                              double scale = max(
                                  viewportFraction,
                                  (1 -
                                      (page - index).abs() +
                                      viewportFraction));
                              if (index == 0) {
                                return Container(
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(
                                        left: page * 20,
                                        right: _height * 0.05,
                                        top: 100 - scale * 35,
                                        bottom: 75 - scale * 15),
                                    child: AddCell(
                                        gradient: listColor[colorIndex ?? 0],
                                        onTap: () {
                                          Navigator.of(context).push(FadeRoute(
                                              page: MakeNoteActivity(
                                            colorIndex: colorIndex,
                                          )));
                                        }));
                              }
                              ElementNote currentElement = list[index - 1];
                              return Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(
                                      right: _height * 0.05,
                                      top: 100 - scale * 35,
                                      bottom: 75 - scale * 15),
                                  child: ListCell(
                                    title: currentElement.title,
                                    date: currentElement.date,
                                  ));
                            }
                          });
                    },
                    child: PageView.builder(
                        controller: controller,
                        itemCount: list.length + 1,
                        itemBuilder: (context, index) {
                          double scale = max(viewportFraction,
                              (1 - (index - index).abs() + viewportFraction));
                          if (index == 0) {
                            return Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(
                                    right: _height * 0.05,
                                    top: 100 - scale * 35,
                                    bottom: 75 - scale * 15),
                                child: AddCell(
                                  gradient: listColor[colorIndex ?? 0],
                                  onTap: () {
                                    Navigator.of(context).push(FadeRoute(
                                        page: MakeNoteActivity(
                                      colorIndex: colorIndex,
                                    )));
                                  },
                                ));
                          }
                          ElementNote currentElement = list[index - 1];
                          return Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(
                                  right: _height * 0.05,
                                  top: 100 - scale * 35,
                                  bottom: 75 - scale * 15),
                              child: ListCell(
                                title: currentElement.title,
                                date: currentElement.date,
                              ));
                        }),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
    // appBar: AppBar(title: Text("Title")),
    // drawer: CustomDrawer(),
    // floatingActionButton: FloatingActionButton(
    //   child: Icon(Icons.add),
    //   onPressed: () => ModalBottomSheets(context).buildIntermediateSheet(
    //     title: 'I\'m so excited to start this journey with you, Name!',
    //     firstSubTitle:
    //         'Let\'s get your great new habit rolling by\ncreating your first story together!',
    //     secSubTitle:
    //         'Get started by clicking the \"Add Story\" card,\nand I\'ll guide you through the process.',
    //     isSubTitleBold: true,
    //     buttonText: 'Write on!',
    //     buttonFunc: () {},
    //   ),
    // ),
    //     body: Stack(
    //   children: [
    //     AnimatedList(
    //       key: _listKey,
    //       initialItemCount: list.length,
    //       itemBuilder: (BuildContext context, int index, Animation animation) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: _buildItem(list[index]),
    //         );
    //       },
    //     ),
    //   ],
    // ));

    // ),
    // );
  }

  // Widget buildError(String message) {
  //   return Center(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8),
  //       child: Text(
  //         message,
  //         style: TextStyle(color: Colors.red),
  //       ),
  //     ),
  //   );
  // }
}
