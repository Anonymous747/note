import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ElementNote {
  DateTime date;
  String title;
  String happened;
  int percentFun;
  int iconPreferences;
  int emoji;
  String randomQuestion;
  String answer;

  ElementNote(
      {this.date,
      this.title,
      this.happened,
      this.percentFun,
      this.iconPreferences,
      this.emoji,
      this.randomQuestion,
      this.answer});

  factory ElementNote.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    DateFormat dateFormat = DateFormat.yMMMd();
    return ElementNote(
      title: data['title'].toString() ?? '',
      happened: data['happened'].toString() ?? '',
      date: dateFormat.parse(data['date']),
      percentFun: int.parse((data['percentFun'] ?? 0).toString()),
      iconPreferences: int.parse((data['iconPreferences'] ?? 0).toString()),
      emoji: int.parse((data['iconPreferences'] ?? 0).toString()),
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
        emoji: data['emoji'],
        randomQuestion: data['randomQuestion'],
        answer: data['answer']);
  }
}
