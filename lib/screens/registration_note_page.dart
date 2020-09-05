import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_register/bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/screens/creation_note_page/creation_extends.dart';
import 'package:note/screens/home_page.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/alert_dialogs.dart';
import 'package:note/widgets/arrow.dart';
import 'package:note/widgets/cells/cells_export.dart';
import 'package:note/widgets/drawer.dart';
import 'package:note/widgets/route_anim/fade_route.dart';
import 'package:note/widgets/texts/opacity_text.dart';

class RegistrationNotePage extends StatefulWidget {
  final int initialIndex;
  final List<ElementNote> notes;

  RegistrationNotePage({this.initialIndex, this.notes});

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
    BlocProvider.of<RegisterBloc>(context).add(RegisterInitialEvent(
        context: context, colorIndex: widget.initialIndex));
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
      print(status);
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
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Login Failure'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Logging In...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          }
          if (state.isSuccess) {
            // BlocProvider.of<RegisterBloc>(context);
            // .add(RegisterSubmitted(email: state));
            //navigation to home page if the user authenticated
            // Navigator.of(context).push(FadeRoute(page: HomePage()));
            Navigator.of(context).pushAndRemoveUntil(
                FadeRoute(page: HomePage(colorIndex: widget.initialIndex)),
                ModalRoute.withName('hp'));
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return buildLoaded(widget.notes, 1);
          },
        ),
      ),
    );
  }

  Widget buildLoaded(List<ElementNote> list, int colorIndex) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    final animation =
        Tween<double>(begin: 0, end: 1).animate(animationController);

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
                                  controller: pageController,
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
