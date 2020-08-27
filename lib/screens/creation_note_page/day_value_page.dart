import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_creation/bloc.dart';
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
    new IconElement(Icon(Icons.work), 'work', iconColor: Colors.white),
    new IconElement(Icon(Icons.home_sharp), 'family', iconColor: Colors.white),
    new IconElement(Icon(Icons.ring_volume_sharp), 'relationship',
        iconColor: Colors.white),
    new IconElement(Icon(Icons.masks), 'education', iconColor: Colors.white),
    new IconElement(Icon(Icons.emoji_flags), 'food', iconColor: Colors.white),
    new IconElement(Icon(Icons.emoji_emotions), 'traveling',
        iconColor: Colors.white),
    new IconElement(Icon(Icons.emoji_events), 'friends',
        iconColor: Colors.white),
    new IconElement(Icon(Icons.emoji_nature), 'exercise',
        iconColor: Colors.white),
    new IconElement(Icon(Icons.add), 'other', iconColor: Colors.black26),
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
                            BlocProvider.of<CreationBloc>(context).add(
                                CreationIconPreferencesChanged(
                                    iconPreferences: index));
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
