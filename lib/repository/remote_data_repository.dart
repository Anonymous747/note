import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note/model/element_note.dart';

abstract class RemDataRep {}

class RemDataRepImpl extends RemDataRep {
  Future<List<ElementNote>> fetchNotes() async {
    var auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();
    if (user != null) {
      QuerySnapshot query =
          await Firestore.instance.collection(user.uid).getDocuments();
      List<ElementNote> elements =
          query.documents.map((doc) => ElementNote.fromFirestore(doc)).toList();
      return elements;
    }
    return new List<ElementNote>();
  }

  Future<bool> makeNote(String title) async {
    var auth = FirebaseAuth.instance;
    try {
      FirebaseUser user = await auth.currentUser();
      if (user != null) {
        //QuerySnapshot query =
        //    await Firestore.instance.collection(user.uid).getDocuments();
        await Firestore.instance.collection(user.uid).document(title).setData({
          "title": title,
          "text": DateTime.now().minute,
        });
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
