import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/bloc/bloc_note/note_bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/widgets/cells/add_cell.dart';
import 'package:note/widgets/drawer.dart';
import 'package:note/widgets/cells/list_cell.dart';
import 'package:note/utils/consts.dart';

class NotePage extends StatefulWidget {
  final FirebaseUser user;
  final int initialIndex;

  NotePage({this.user, this.initialIndex});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  PageController controller;
  NoteBloc bloc;
  double viewportFraction = 0.8;
  double pageOffset = 0;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<NoteBloc>(context);
    bloc.add(FetchNotes());
    controller = PageController(
        initialPage: pageOffset.round(), viewportFraction: viewportFraction);
    controller.addListener(() {
      setState(() {
        pageOffset = controller.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: BlocListener<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteErrorState) {
            buildError(state.message);
          }
        },
        child: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteInitState) {
              return Container();
            } else if (state is NoteLoadingState) {
              return buidLoading();
            } else if (state is NoteLoadedState) {
              return buildLoaded(state.element);
            } else if (state is NoteErrorState) {
              return buildError(state.message);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buidLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildItem(ElementNote note, [int index]) {
    return ListTile(
      key: ValueKey<ElementNote>(note),
      title: Text(note.title),
      subtitle: Text(note.text),
    );
  }

  Widget buildLoaded(List<ElementNote> list) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          selectedFontSize: 10,
          showUnselectedLabels: false,
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black),
          unselectedItemColor: Colors.black26,
          iconSize: 30,
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.pencil), title: Text('●')),
            BottomNavigationBarItem(
                icon: Icon(Icons.ad_units_sharp), title: Text('●')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), title: Text('●')),
          ],
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: _width * 0.25,
                color: Colors.black12,
              ),
            ),
            // Padding(
            // padding: const EdgeInsets.only(top: 50, left: 30),
            Padding(
              padding: EdgeInsets.only(top: _height * 0.1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: _height * 0.05),
                          icon: Icon(Icons.settings, size: 30),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          })
                    ],
                  ),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
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
                                      fontSize: 28, color: Colors.black87)),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: _height * 0.05),
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
                    child: PageView.builder(
                        controller: controller,
                        physics: BouncingScrollPhysics(),
                        // scrollDirection: Axis.horizontal,
                        itemCount: textList.length + 1,
                        itemBuilder: (context, index) {
                          double scale = max(
                              viewportFraction,
                              (1 -
                                  (pageOffset - index).abs() +
                                  viewportFraction));
                          if (index == 0) {
                            return Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(
                                    right: 60,
                                    top: 100 - scale * 35,
                                    bottom: 75 - scale * 15),
                                child: AddCell());
                          }
                          return Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(
                                  right: 60,
                                  top: 100 - scale * 35,
                                  bottom: 75 - scale * 15),
                              child: ListCell(
                                text: textList[index - 1],
                              ));

                          // if (controller.page == index) {
                          //   return Padding(
                          //     padding:
                          //         const EdgeInsets.only(top: 40, bottom: 20),
                          //     child: ListCell(
                          //       text: textList[index],
                          //     ),
                          //   );
                          // } else {
                          //   return Padding(
                          //     padding:
                          //         const EdgeInsets.only(top: 80, bottom: 20),
                          //     child: ListCell(
                          //       text: textList[index],
                          //     ),
                          //   );
                          // }
                        }),
                  ))
                ],
              ),
            ),
          ],
        ));
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

    /*ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                child: ListTile(
                  title: Text(list[index].title),
                  subtitle: Text(list[index].text),
                  onTap: () {
                    Navigator.of(context).pushNamed('ap');
                  },
                ),
              ));*/
    // },
    // ),
    // );
  }

  Widget buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
