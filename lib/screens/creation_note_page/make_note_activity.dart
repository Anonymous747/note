import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_account_creation/account_creation_bloc.dart';
import 'package:note/bloc/bloc_account_creation/bloc.dart';
import 'package:note/bloc/bloc_creation/bloc.dart';
import 'package:note/screens/creation_note_page/creation_extends.dart';
import 'package:note/screens/registration_note_page.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/alert_dialogs.dart';
import 'package:note/widgets/logo_widget.dart';

class MakeNoteActivity extends StatefulWidget {
  final int colorIndex;

  MakeNoteActivity({this.colorIndex});

  @override
  _MakeNoteActivityState createState() => _MakeNoteActivityState();
}

class _MakeNoteActivityState extends State<MakeNoteActivity> {
  PageController controller;
  int _currentIndex;
  Tween<double> positionLogo;
  ValueNotifier<double> logoNotifier;
  bool isLogoStartState;
  List<Widget> pages;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    controller = PageController(initialPage: _currentIndex);
    logoNotifier = ValueNotifier<double>(0);
    positionLogo = Tween<double>(begin: 0.0, end: 0.0);
    isLogoStartState = true;

    controller.addListener(() {
      _currentIndex = controller.page.round();
      logoNotifier.value = controller.page;
    });
    Color currentColor = listColor[widget.colorIndex].colors.last;
    pages = [
      FirstNotePage(
        colorIndex: widget.colorIndex,
        buttonFunction: transitionFunction,
      ),
      MoodPage(
        sliderFunction: transitionFunction,
      ),
      DayValuePage(
        buttonFunction: transitionFunction,
      ),
      HappenedPage(
        textColor: currentColor,
        buttonFunction: transitionFunction,
      ),
      SmilePage(
        buttonFunction: transitionFunction,
      ),
      RandomQuestionPage(
        buttonFunction: transitionFunction,
        textColor: currentColor,
      ),
      TitlePage(
        textColor: currentColor,
        backFunction: onBackPressed,
        isAuthorized: currentUser == null ? false : true,
        colorIndex: widget.colorIndex,
      )
    ];

    _userStatus();
  }

  void _userStatus() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  @override
  void dispose() {
    logoNotifier.dispose();
    controller.dispose();
    super.dispose();
  }

  void transitionFunction() {
    if (controller.page == 0) isLogoStartState = false;
    if (controller.page == pages.length - 2) isLogoStartState = true;
    controller.animateToPage(_currentIndex + 1,
        duration: Duration(milliseconds: 1000), curve: Curves.easeInExpo);
  }

  void clearFunction() {
    if (controller.page == 0)
      Navigator.of(context).pop();
    else {
      AlertDialogs(context).onBackPressedInCreatingNote();
    }
  }

  Future<bool> onBackPressed() async {
    if (controller.page != 0) {
      if (controller.page == pages.length - 1) isLogoStartState = false;
      if (controller.page == 1) isLogoStartState = true;
      controller.animateToPage(_currentIndex - 1,
          duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
      // return true;
    } else {
      AlertDialogs(context).onBackPressedInCreatingNote();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: onBackPressed,
        child: BlocProvider.value(
            value: CreationBloc(),
            child: BlocBuilder<CreationBloc, CreationState>(
                builder: (context, state) {
              if (state is CreationSuccess) {
                BlocProvider.of<CreationBloc>(context)
                    .add(CreationSuccesEvent());
                return BlocProvider.value(
                  value: AccountCreationBloc()
                    ..add(AccountNoteCreatedEvent(
                        context: context,
                        colorIndex: widget.colorIndex,
                        note: state.note)),
                  child: RegistrationNotePage(
                    note: state.note,
                    initialIndex: widget.colorIndex,
                  ),
                );
              } else if (state is CreationMoveToNote) {
                return BlocProvider.value(
                  value: AccountCreationBloc(),
                  child: RegistrationNotePage(
                    note: state.note,
                    initialIndex: widget.colorIndex,
                  ),
                );
              }
              return Scaffold(
                body: Stack(
                  children: [
                    Hero(
                      tag: 'gradient0',
                      child: TweenAnimationBuilder(
                        duration: Duration(milliseconds: 400),
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: listColor[widget.colorIndex],
                            )),
                        builder: (BuildContext context, value, Widget child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        tween: Tween(begin: 2.3, end: 2.3),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      // decoration: BoxDecoration(
                      //     gradient: listColor[widget.colorIndex]),
                      child: PageView.builder(
                        physics: NeverScrollableScrollPhysics(parent: null),
                        scrollDirection: Axis.vertical,
                        controller: controller,
                        itemBuilder: (context, index) => pages[index],
                      ),
                    ),
                    AnimatedPositioned(
                      right: _width * 0.01,
                      top: _height * 0.03,
                      duration: Duration(milliseconds: 500),
                      child: IconButton(
                        icon: Icon(
                          Icons.clear,
                        ),
                        onPressed: clearFunction,
                      ),
                    ),
                    TweenAnimationBuilder<double>(
                        child: LogoWidget(),
                        tween: Tween(begin: 0, end: 0.9),
                        duration: Duration(milliseconds: 500),
                        builder: (context, animation, child) {
                          return ValueListenableBuilder<double>(
                            valueListenable: logoNotifier,
                            builder: (context, value, child) {
                              return AnimatedPositioned(
                                duration: Duration(milliseconds: 700),
                                child: TweenAnimationBuilder<double>(
                                  duration: Duration(
                                    milliseconds: 700,
                                  ),
                                  child: LogoWidget(),
                                  tween: isLogoStartState
                                      ? Tween(begin: 0, end: 0)
                                      : Tween(begin: 0, end: 0.3),
                                  builder: (context, value, child) {
                                    return Transform.scale(
                                      scale: animation - value,
                                      child: child,
                                    );
                                  },
                                ),
                                top: isLogoStartState
                                    ? _height * 0.15
                                    : _height * 0.05,
                                left: isLogoStartState ? _width / 2 - 50 : 0,
                              );
                            },
                          );
                        }),
                    ValueListenableBuilder(
                        valueListenable: logoNotifier,
                        builder: (_, page, __) {
                          return AnimatedPositioned(
                            top: _height * 0.85,
                            right: isLogoStartState ? -40 : 10,
                            width: 40,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeOutCubic,
                            child: Column(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.expand_less,
                                      color: _currentIndex != 1
                                          ? Colors.white
                                          : Colors.white54),
                                  onPressed: onBackPressed,
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.expand_more,
                                    color: _currentIndex != 3
                                        ? Colors.white
                                        : Colors.white54,
                                  ),
                                  onPressed: transitionFunction,
                                )
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              );
            })));
  }
}
