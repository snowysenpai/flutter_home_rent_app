import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageApi {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore db = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static Future<bool> userExists() async {
    return (await db.collection("users").doc(auth.currentUser!.uid).get())
        .exists;
  }
}
