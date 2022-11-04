import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/myuser.dart';

class LoginModel extends ChangeNotifier {
  bool isObscure = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Map<int, String> errorCode = {
    1: '[firebase_auth/invalid-email] The email address is badly formatted.',
    2: '[firebase_auth/email-already-in-use] The email address is already in use by another account.',
    3: '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.',
  };

  MyUser? user;
  String? email;
  String? password;

  bool isLoading = false;

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
    email = text;
    notifyListeners();
  }

  void setPassword(String text) {
    password = password;
    notifyListeners();
  }

  Future login() async {
    email = emailController.text;
    password = passwordController.text;

    if (email != null && password != null) {
      // ログイン
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      final currentUser = FirebaseAuth.instance.currentUser;
      user?.uID = currentUser!.uid;
    }
  }

  Future sendPasswordResetEmail() async {
    if (emailController.text.isEmpty) {
      throw 'メールアドレスが入力されていません';
    }

    final emailText = emailController.text;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailText);
      return 'success';
    } catch (error) {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(error.toString()),
      );
    }
  }
}
