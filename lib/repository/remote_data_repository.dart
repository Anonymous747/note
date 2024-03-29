import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
    return List<ElementNote>();
  }

  Future<void> makeNote({
    DateTime date,
    String title,
    String happened,
    int percentFun,
    int iconPreferences,
    int emoji,
    String randomQuestion,
    String answer,
    String collectionName = 'Note',
  }) async {
    try {
      FirebaseUser user = await authentication.currentUser();
      if (user != null) {
        //QuerySnapshot query =
        //    await Firestore.instance.collection(user.uid).getDocuments();
        final currentDate = new DateFormat.yMMMd().format(new DateTime.now());

        await Firestore.instance.collection(user.uid).document(collectionName).collection(currentDate).document(title).setData({
          'title': title,
          'date': new DateFormat.yMMMd().format(new DateTime.now()),
          'happened': happened,
          'iconPreferences': iconPreferences,
          'percentFun': percentFun,
          'emoji': emoji,
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
