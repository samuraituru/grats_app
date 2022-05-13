import 'package:flutter/material.dart';

class GroupModel extends ChangeNotifier {
  var controller = TextEditingController();
  var editText = '';
  var fruits = <String>['例)反則数'];

  void clearAdd() {
    this.fruits.add(editText);
    this.controller.clear();
    notifyListeners();
  }
}