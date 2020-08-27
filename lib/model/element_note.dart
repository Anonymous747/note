import 'package:cloud_firestore/cloud_firestore.dart';

class ElementNote {
  DateTime date;
  String title;
  String happened;
  int percentFun;
  int iconPreferences;
  int feelingIcon;
  String randomQuestion;
  String answer;

  ElementNote(
      {this.date,
      this.title,
      this.happened,
      this.percentFun,
      this.iconPreferences,
      this.feelingIcon,
      this.randomQuestion,
      this.answer});

  factory ElementNote.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return ElementNote(
      title: data['title'].toString() ?? '',
      happened: data['happened'].toString() ?? '',
      date: DateTime.parse(data['date'].toString()) ?? DateTime.now(),
      percentFun: int.parse(data['percentFun'].toString()),
      iconPreferences: int.parse(data['iconPreferences'].toString()),
      feelingIcon: int.parse(data['iconPreferences'].toString()),
      randomQuestion: data['randomQuestion'].toString() ?? '',
      answer: data['answer'].toString() ?? '',
    );
  }

  factory ElementNote.fromMap(Map data) {
    data = data ?? {};
    return ElementNote(
        title: data['title'],
        happened: data['text'],
        date: data['date'],
        percentFun: data['percentFun'],
        iconPreferences: data['iconPreferences'],
        feelingIcon: data['feelingIcon'],
        randomQuestion: data['randomQuestion'],
        answer: data['answer']);
  }
}
