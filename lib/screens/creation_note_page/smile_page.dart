import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_creation/bloc.dart';
import 'package:note/model/icon_element.dart';
import 'package:note/widgets/texts/font_white_text.dart';

class SmilePage extends StatefulWidget {
  final Function buttonFunction;

  SmilePage({@required this.buttonFunction});

  @override
  _SmilePageState createState() => _SmilePageState();
}

class _SmilePageState extends State<SmilePage> {
  PageController controller;
  double _viewportFraction = 0.4;
  double iconSize = 100;
  ValueNotifier<double> smileNotifier;
  List<IconElement> icons = [
    new IconElement(Icon(Icons.emoji_emotions), 'happy'),
    new IconElement(Icon(Icons.emoji_emotions), 'blessed'),
    new IconElement(Icon(Icons.accessibility_new), 'happy'),
    new IconElement(Icon(Icons.emoji_emotions), 'happy'),
    new IconElement(Icon(Icons.emoji_emotions), 'happy'),
    new IconElement(Icon(Icons.emoji_emotions), 'happy'),
    new IconElement(Icon(Icons.emoji_emotions), 'happy'),
    new IconElement(Icon(Icons.emoji_emotions), 'happy'),
    new IconElement(Icon(Icons.emoji_emotions), 'happy'),
  ];

  @override
  void initState() {
    super.initState();
    controller =
        PageController(initialPage: 0, viewportFraction: _viewportFraction);
    smileNotifier = ValueNotifier<double>(0);

    controller.addListener(() {
      smileNotifier.value = controller.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: _height * 0.2, right: 20, left: 20),
      child: Column(
        children: [
          Expanded(
            child: TitleWhiteText(
              text: 'How did you feel throughout the day?',
            ),
          ),
          Expanded(
            flex: 3,
            child: ValueListenableBuilder<double>(
              valueListenable: smileNotifier,
              builder: (context, currentSmile, child) => PageView.builder(
                controller: controller,
                // physics: BouncingScrollPhysics(parent: null),
                scrollDirection: Axis.horizontal,
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  double scale = max<double>(_viewportFraction,
                      1 - (currentSmile - index).abs() + _viewportFraction);
                  return Padding(
                    padding: EdgeInsets.only(top: 100 - scale * 30),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<CreationBloc>(context).add(
                            CreationFeelingIconChanged(feelingIcon: index));
                        widget.buttonFunction();
                      },
                      child: Column(
                        children: [
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 300),
                            opacity: max<double>(
                                0.5, 1 - (currentSmile - index).abs()),
                            child: IconTheme(
                              data: IconThemeData(
                                  size: (scale + 2) * 30, color: Colors.white),
                              child: icons[index].icon,
                            ),
                          ),
                          SizedBox(height: 5),
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 200),
                            opacity: max<double>(
                                0, 1 - (currentSmile - index).abs()),
                            child: Text(icons[index].iconName,
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
