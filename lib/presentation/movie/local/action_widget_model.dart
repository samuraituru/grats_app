import 'package:flutter/material.dart';

class ActionWidgetModel extends ChangeNotifier {
  int counter = 0;

  void increment (){
    counter = counter++;
    notifyListeners();
  }
}