import 'package:flutter/material.dart';
import 'package:note/model/icon_element.dart';
import 'package:note/widgets/texts/font_white_text.dart';

class DayValuePage extends StatefulWidget {
  final String value;
  final Function buttonFunction;

  DayValuePage({this.value, this.buttonFunction});

  @override
  _DayValuePageState createState() => _DayValuePageState();
}

class _DayValuePageState extends State<DayValuePage> {
  List<IconElement> icons = [
    new IconElement(Icon(Icons.work), 'work', Colors.white),
    new IconElement(Icon(Icons.home_sharp), 'family', Colors.white),
    new IconElement(
        Icon(Icons.ring_volume_sharp), 'relationship', Colors.white),
    new IconElement(Icon(Icons.masks), 'education', Colors.white),
    new IconElement(Icon(Icons.access_time), 'food', Colors.white),
    new IconElement(Icon(Icons.access_time), 'traveling', Colors.white),
    new IconElement(Icon(Icons.access_time), 'friends', Colors.white),
    new IconElement(Icon(Icons.public), 'exercise', Colors.white),
    new IconElement(Icon(Icons.add), 'other', Colors.black26),
  ];

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: _height * 0.2, left: 20, right: 20),
      child: Stack(
        children: [
          TitleWhiteText(text: 'Nice - what made today MOOD'),
          Padding(
            padding: EdgeInsets.only(top: _height * 0.15),
            child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(
                    9,
                    (index) => InkWell(
                          onTap: () {
                            widget.buttonFunction();
                          },
                          child: Column(
                            children: [
                              IconTheme(
                                data: IconThemeData(
                                    color:
                                        icons[index].iconColor.withOpacity(0.7),
                                    size: 30),
                                child: icons[index].icon,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(icons[index].iconName,
                                  style: TextStyle(color: Colors.white30))
                            ],
                          ),
                        ))),
          ),
        ],
      ),
    );
  }
}
