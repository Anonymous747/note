import 'package:flutter/material.dart';
import 'package:note/widgets/texts/font_white_text.dart';

class MoodPage extends StatefulWidget {
  @override
  _MoodPageState createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  ValueNotifier<double> sliderNotifier;

  @override
  void initState() {
    super.initState();
    sliderNotifier = ValueNotifier<double>(50);
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        top: _height * 0.2,
        left: _width * 0.05,
        right: _width * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleWhiteText(
            text: 'How was your day today?',
            align: TextAlign.start,
          ),
          ValueListenableBuilder(
              valueListenable: sliderNotifier,
              builder: (context, points, child) {
                return child;
              },
              child: Slider(
                  value: 50,
                  min: 0,
                  max: 100,
                  onChanged: (double value) {
                    sliderNotifier.value = value;
                  })),
        ],
      ),
    );
  }
}
