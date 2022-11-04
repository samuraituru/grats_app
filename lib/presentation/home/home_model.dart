import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  int currentIndex = 0;

  void onTabTapped(int index) async {
    currentIndex = index;
    notifyListeners();
  }

  bool isLogin = false;
  listenAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        isLogin = false;
        notifyListeners();
      } else {
        print('User is signed in!');
        isLogin = true;
        notifyListeners();
      }
    });
  }
}
