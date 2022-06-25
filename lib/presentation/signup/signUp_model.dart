import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  bool isObscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? email;
  String? password;

  bool isLoading = false;

 void changeObscure(){
   // アイコンがタップされたら現在と反対の状態をセットする
   isObscure = !isObscure;
   notifyListeners();
 }

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
    this.email = emailController.text;
    this.password = passwordController.text;

    if (emailController.text == null) {
      throw 'Emailが入力されていません';
    }
    if (passwordController.text == null || passwordController.text.isEmpty) {
      throw 'Passwordが入力されていません';
    }

    // firebase authでユーザー作成
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    final user = userCredential.user;

    if (user != null) {
      final uID = user.uid;

      // Firestoreに追加

      final doc = FirebaseFirestore.instance.collection('Users').doc(uID);
      await doc.set({
        'UID': uID,
        'email': email,
        'imgURL': '',
      });
    }
  }
}