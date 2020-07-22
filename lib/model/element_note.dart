import 'package:cloud_firestore/cloud_firestore.dart';

class ElementNote {
  final String title;
  final String text;

  ElementNote({this.title, this.text});

  factory ElementNote.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return ElementNote(
      title: data['title'].toString() ?? '',
      text: data['text'].toString() ?? '',
    );
  }

  factory ElementNote.fromMap(Map data) {
    data = data ?? {};
    return ElementNote(title: data['title'], text: data['text']);
  }
}
