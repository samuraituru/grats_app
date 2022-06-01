import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  String? email;
  String? password;

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setEmail(String text) {
    this.email = text;
    notifyListeners();
  }

  void setPassword(String text) {
    this.password = text;
    notifyListeners();
  }
  Future signUp() async {
    this.email = titleController.text;
    this.password = authorController.text;

    if (email != null && password != null) {
      // firebase authでユーザー作成
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      final user = userCredential.user;

      if (user != null) {
        final uID = user.uid;

        // firestoreに追加

        final doc = FirebaseFirestore.instance.collection('Users').doc(uID);
        await doc.set({
          'uID': uID,
          'email': email,
        });

      }
    }
  }
}