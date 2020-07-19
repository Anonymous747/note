import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:note/model/element_note.dart';
import 'package:note/model/element_task.dart';

abstract class UserRep {
  FirebaseAuth auth;

  UserRep(this.auth);

  Future<ElementTask> getTask();
  Future<List<ElementNote>> getNote();
}

class UserRepImpl extends UserRep {
  FirebaseAuth auth;

  UserRepImpl({@required this.auth}) : super(auth);

  @override
  Future<ElementTask> getTask() async {}

  @override
  Future<List<ElementNote>> getNote() async {
    FirebaseUser user = await auth.currentUser();
    List<ElementNote> listElememt = new List();
    Firestore.instance.collection((user).uid).snapshots().forEach((element) {
      element.documents.map((e) => e.data.forEach((key, value) {
            if (value.runtimeType is String) {
              listElememt.add(new ElementNote(key, value));
            }
          }));
    });
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
    return listElememt;
  }
}
