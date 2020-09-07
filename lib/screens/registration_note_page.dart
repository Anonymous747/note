import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_account_creation/account_creation_bloc.dart';
import 'package:note/bloc/bloc_account_creation/bloc.dart';
import 'package:note/bloc/bloc_register/bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/screens/creation_note_page/creation_extends.dart';
import 'package:note/screens/home_page.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/alert_dialogs.dart';
import 'package:note/widgets/arrow.dart';
import 'package:note/widgets/cells/cells_export.dart';
import 'package:note/widgets/drawer.dart';
import 'package:note/widgets/modal_bottom_sheets.dart/modal_bottom_sheets.dart';
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
  final double viewportFraction = 0.7;
  double pageOffset;
  ValueNotifier<double> _pageNotifier;
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<AccountCreationBloc>(context).add(
    //     AccountCreationInitialEvent(
    //         context: context, colorIndex: widget.initialIndex));
    pageOffset = 0;
    pageController = PageController(
        initialPage: pageOffset.round(), viewportFraction: viewportFraction);
    _pageNotifier = ValueNotifier<double>(pageOffset);
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    pageController.addListener(() {
      pageOffset = pageController.page;
      _pageNotifier.value = pageController.page;
    });
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
    _pageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCreationBloc>(
      create: (context) => AccountCreationBloc(),
      child: BlocBuilder<AccountCreationBloc, AccountCreationState>(
        builder: (context, state) {
          if (state is AccountCreationInitial) {
            return buildLoaded(widget.note, widget.initialIndex);
          } else if (state is AccountCreationGreeting) {
            ModalBottomSheets(context).buildIntermediateSheet(
              title: 'I\'m so excited to start this journey with you, Name!',
              firstSubTitle:
                  'Let\'s get your great new habit rolling by\ncreating your first story together!',
              secSubTitle:
                  'Get started by clicking the \"Add Story\" card,\nand I\'ll guide you through the process.',
              isSubTitleBold: true,
              buttonText: 'Write on!',
              buttonFunc: () {
                Navigator.of(context).pop(false);
                print('ok');
              },
              colorIndex: widget.initialIndex,
            );
          } else if (state is AccountNoteCreatedState) {
            return buildLoaded(state.note, widget.initialIndex);
          }
        },
      ),
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
                                  controller: pageController,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    if (index + 10 >= page &&
                                        index - 10 <= page) {
                                      double scale = max(
                                          viewportFraction,
                                          (1 -
                                              (page - index).abs() +
                                              viewportFraction));
                                      if (note == null) {
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
                                        ElementNote currentElement = note;
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
