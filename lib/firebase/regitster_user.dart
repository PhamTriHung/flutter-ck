import 'package:ck/model/Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> forgotPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-email') {
      // ignore: avoid_print
      print(e);
    } else {
      // ignore: avoid_print
      print("Khong gui dc");
    }
  }
}
