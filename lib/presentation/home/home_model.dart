import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeModel extends ChangeNotifier {
  int currentIndex = 0;

  void onTabTapped(int index) async {
    currentIndex = index;
    notifyListeners();
  }
}