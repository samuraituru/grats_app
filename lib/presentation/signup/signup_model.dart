import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  bool isObscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? email;
  String? password;
  List<dynamic> groupIDs =[];

  bool isLoading = false;

  Map<int,String> errorCode = {
    1:'[firebase_auth/invalid-email] The email address is badly formatted.',
    2:'[firebase_auth/email-already-in-use] The email address is already in use by another account.',
    3:'[firebase_auth/user-not-found] There is no user record corresponding to this identifier.',
  };

  void changeObscure() {
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

  Future<void> signUp() async {
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
    final user = await userCredential.user;

    if (user != null) {
      final myUID = user.uid;

      // Firestoreに追加

      final doc =  await FirebaseFirestore.instance.collection('Users').doc(myUID);
      await doc.set({
        'UID': myUID,
        'email': email,
        'imgURL': '',
        'groupIDs': addGroupIDs(),
        'userName': '',
        'userTarget': '',
      });
    }
  }
  List<dynamic> addGroupIDs() {
    return groupIDs;
  }
}
