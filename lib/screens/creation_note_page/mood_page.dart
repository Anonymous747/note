import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_creation/bloc.dart';
import 'package:note/model/smile_element.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/smiles/smile_export.dart';
import 'package:note/widgets/texts/font_white_text.dart';

class MoodPage extends StatefulWidget {
  final Function sliderFunction;

  MoodPage({this.sliderFunction});

  @override
  _MoodPageState createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  ValueNotifier<double> sliderNotifier;

  //  List<SmileElement> smiles = [
  //   const SmileElement(RealyTerribleSmile(), 'really terrible'),
  //   const SmileElement(SomewhatBadSmile(), 'somewhat bad'),
  //   const SmileElement(CompletelyOkaySmile(), 'completely okay'),
  //   const SmileElement(PrettyGoodSmile(), 'pretty good'),
  //   const SmileElement(SuperAwesomeSmile(), 'super awesome'),
  // ];

  @override
  void initState() {
    super.initState();
    sliderNotifier = ValueNotifier<double>(50);

    sliderNotifier.addListener(() {});
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
      child: Stack(
        children: [
          TitleWhiteText(
            text: 'How was your day today?',
            align: TextAlign.start,
          ),
          ValueListenableBuilder<double>(
              valueListenable: sliderNotifier,
              builder: (context, points, child) {
                int index = (points / 20).floor();
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      smiles[index].smile,
                      SizedBox(
                        height: _height * 0.05,
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 3,
                          inactiveTickMarkColor: Colors.white,
                          activeTickMarkColor: Colors.white,
                          activeTrackColor: Colors.white70,
                          disabledActiveTrackColor: Colors.white,
                          valueIndicatorColor: Colors.white,
                          inactiveTrackColor: Colors.black26,
                          thumbColor: Colors.white,
                          overlayColor: Colors.transparent,
                        ),
                        child: Slider(
                            value: sliderNotifier.value,
                            min: 0,
                            max: 99,
                            onChanged: (double value) {
                              sliderNotifier.value = value;
                            },
                            onChangeEnd: (point) {
                              print(point.round());
                              BlocProvider.of<CreationBloc>(context).add(
                                  CreationPercentFunChanged(
                                      percentFun: point.round()));
                              widget.sliderFunction();
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rate your day'.toUpperCase(),
                            style: TextStyle(color: Colors.white24),
                          ),
                          Text(
                            smiles[index].smileName.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ]);
              })
        ],
      ),
    );
  }
}
