import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:note/model/element_note.dart';

abstract class RemDataRep {}

class RemDataRepImpl extends RemDataRep {
  FirebaseAuth authentication;

  RemDataRepImpl() {
    authentication = FirebaseAuth.instance;
  }

  Future<List<ElementNote>> fetchNotes() async {
    FirebaseUser user = await authentication.currentUser();
    if (user != null) {
      QuerySnapshot query =
          await Firestore.instance.collection(user.uid).getDocuments();
      List<ElementNote> elements =
          query.documents.map((doc) => ElementNote.fromFirestore(doc)).toList();
      return elements;
    }
    return new List<ElementNote>();
  }

  Future<void> makeNote(
      {DateTime date,
      String title,
      String happened,
      int percentFun,
      int iconPreferences,
      int feelingIcon,
      String randomQuestion,
      String answer}) async {
    try {
      FirebaseUser user = await authentication.currentUser();
      if (user != null) {
        //QuerySnapshot query =
        //    await Firestore.instance.collection(user.uid).getDocuments();
        await Firestore.instance.collection(user.uid).document(title).setData({
          'title': title,
          'date': '${date.month}.${date.day}.${date.year}',
          'happened': happened,
          'percentFun': percentFun,
          'feelingIcon': feelingIcon,
          'randomQuestion': randomQuestion,
          'answer': answer
        });
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> removeNote(String text) async {
    try {
      FirebaseUser user = await authentication.currentUser();
      if (user != null) {
        QuerySnapshot snap =
            await Firestore.instance.collection(user.uid).getDocuments();
        snap.documents.forEach((element) {
          if (text == element.documentID) {
            snap.documents.removeAt(snap.documents.indexOf(element));
          }
        });
      }
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
