import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_account_creation/account_creation_bloc.dart';
import 'package:note/bloc/bloc_account_creation/bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/screens/creation_note_page/creation_extends.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/alert_dialogs.dart';
import 'package:note/widgets/arrow.dart';
import 'package:note/widgets/cells/cells_export.dart';
import 'package:note/widgets/cells/registr_note_cell.dart';
import 'package:note/widgets/drawer.dart';
import 'package:note/widgets/route_anim/fade_route.dart';
import 'package:note/widgets/texts/opacity_text.dart';

class RegistrationNotePage extends StatefulWidget {
  final int initialIndex;
  final ElementNote note;

  RegistrationNotePage({this.initialIndex, this.note});

  @override
  _RegistrationNotePageState createState() => _RegistrationNotePageState();
}

class _RegistrationNotePageState extends State<RegistrationNotePage>
    with SingleTickerProviderStateMixin {
  PageController pageController;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        animationController.reverse();
      else if (status == AnimationStatus.dismissed)
        animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCreationBloc, AccountCreationState>(
      builder: (context, state) {
        return buildLoaded(widget.note, widget.initialIndex);
      },
    );
  }

  Widget buildLoaded(ElementNote note, int colorIndex) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    final animation =
        Tween<double>(begin: 0, end: 1).animate(animationController);

    // if (note == null) note = new ElementNote();
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
            // Padding(
            //   padding: EdgeInsets.only(top: _height * 0.17, left: 35),
            //   child: OpacityText(
            //     text: 'Your stories',
            //   ),
            // ),
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
                  Expanded(child: Builder(builder: (context) {
                    if (note == null) {
                      return Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                            left: _width * 0.15,
                            right: _width * 0.15,
                            top: 100,
                            bottom: _height * 0.2),
                        child: AddCell(
                            gradient: listColor[widget.initialIndex],
                            onTap: () {
                              Navigator.of(context).push(FadeRoute(
                                  page: MakeNoteActivity(
                                colorIndex: widget.initialIndex,
                              )));
                            }),
                      );
                    } else {
                      ElementNote currentElement = note;
                      return Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                            left: _width * 0.15,
                            right: _width * 0.15,
                            top: 60,
                            bottom: _height * 0.2),
                        child: Container(
                            child: RegistrNoteCell(
                          date: DateTime.now(),
                          title: currentElement.title,
                          percentFun: currentElement.percentFun,
                        )),
                      );
                    }
                  })),
                  AnimatedBuilder(
                    animation: animation,
                    child: Arrow(
                      color: Color.fromRGBO(192, 192, 192, 1),
                    ),
                    builder: (context, child) {
                      final yPos = _height * 0.05 * animation.value;
                      return Transform.translate(
                          offset: Offset(0, -yPos), child: child);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
