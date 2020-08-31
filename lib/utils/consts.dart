import 'package:flutter/material.dart';
import 'package:note/model/icon_element.dart';
import 'package:note/model/smile_element.dart';
import 'package:note/widgets/smiles/smile_export.dart';

const List<LinearGradient> listColor = [
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.indigoAccent,
      Colors.teal,
    ],
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.deepPurple,
      Colors.purple,
    ],
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(249, 161, 154, 1),
      Colors.pinkAccent,
    ],
  ),
];

const List<SmileElement> smiles = [
  const SmileElement(RealyTerribleSmile(), 'really terrible'),
  const SmileElement(SomewhatBadSmile(), 'somewhat bad'),
  const SmileElement(CompletelyOkaySmile(), 'completely okay'),
  const SmileElement(PrettyGoodSmile(), 'pretty good'),
  const SmileElement(SuperAwesomeSmile(), 'super awesome'),
];

const List<String> questions = [
  'Some question...',
  'What\'s the craziest thing you\'ve ever done?',
  'fdfd',
];

const List<IconElement> icons = [
  const IconElement(Icon(Icons.work), 'work', iconColor: Colors.white),
  const IconElement(Icon(Icons.home_sharp), 'family', iconColor: Colors.white),
  const IconElement(Icon(Icons.ring_volume_sharp), 'relationship',
      iconColor: Colors.white),
  const IconElement(Icon(Icons.masks), 'education', iconColor: Colors.white),
  const IconElement(Icon(Icons.emoji_flags), 'food', iconColor: Colors.white),
  const IconElement(Icon(Icons.emoji_emotions), 'traveling',
      iconColor: Colors.white),
  const IconElement(Icon(Icons.emoji_events), 'friends',
      iconColor: Colors.white),
  const IconElement(Icon(Icons.emoji_nature), 'exercise',
      iconColor: Colors.white),
  const IconElement(Icon(Icons.add), 'other', iconColor: Colors.black26),
];

const List<IconElement> emojis = [
  const IconElement(Icon(Icons.emoji_emotions), 'happy'),
  const IconElement(Icon(Icons.emoji_emotions), 'blessed'),
  const IconElement(Icon(Icons.accessibility_new), 'happy'),
  const IconElement(Icon(Icons.emoji_emotions), 'happy'),
  const IconElement(Icon(Icons.emoji_emotions), 'happy'),
  const IconElement(Icon(Icons.emoji_emotions), 'happy'),
  const IconElement(Icon(Icons.emoji_emotions), 'happy'),
  const IconElement(Icon(Icons.emoji_emotions), 'happy'),
  const IconElement(Icon(Icons.emoji_emotions), 'happy'),
];

const List<String> months = [
  'Jan',
  'Feb',
  'March',
  'Apr',
  'May',
  'June',
  'July',
  'Aug',
  'Sept',
  'Oct',
  'Nov',
  'Dec'
];

const List<String> fullMonths = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
