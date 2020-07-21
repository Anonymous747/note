import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:note/model/element_note.dart';
import 'package:note/model/element_task.dart';

abstract class UserRep {
  FirebaseUser user;

  UserRep(this.user);

  Stream<ElementNote> getTask();
  Stream<List<ElementNote>> getNote();
}

class UserRepImpl extends UserRep {
  FirebaseUser user;

  UserRepImpl({@required this.user}) : super(user);

  @override
  Stream<ElementNote> getTask() {
    var db = Firestore.instance;
    DocumentReference ref = db.collection("notes").document("note");
    var ex = ref.snapshots().forEach((snap) => ElementNote.fromMap(snap.data));
    return ref.snapshots().map((snap) => ElementNote.fromMap(snap.data));
  }

  @override
  Stream<List<ElementNote>> getNote() {
    var db = Firestore.instance;
    CollectionReference ref =
        db.collection("notes").document("note").collection('objects');
    return ref.snapshots().map((list) =>
        list.documents.map((doc) => ElementNote.fromFirestore(doc)).toList());
    //   .forEach((element) {
    // element.documents.map((e) => e.data.forEach((key, value) {
    //       if (value.runtimeType is String) {
    //         listElememt.add(new ElementNote(title: key, text: value));
    //       }

    //.getDocuments()
    // .then((value) => value.documents.forEach((element) {
    //       print(element.data.length);
    //     }));

    // if (user.uid.isNotEmpty) {
    //   snapshot.data.documents.map((el) {
    //     el.data.forEach((key, value) {
    //       if (value.runtimeType is String) {
    //         listElememt.add(new ElementNote(key, value));
    //       }
    //     });
    //   });
    // }
  }
}
