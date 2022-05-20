import 'package:flutter/material.dart';

class TestModel1 extends ChangeNotifier {
  var action = <String>['例)反則数（長押しで削除）'];
  Color mycolor1 = Colors.lightBlue;
  void colorChanged1(color) {
    this.mycolor1 = color;
    notifyListeners();
  }
  void actionClearAdd() {
    this.action.add(actionText1);
    this.controller.clear();
    notifyListeners();
  }
  late final List<GlobalObjectKey> keys;
  var controller = TextEditingController();
  var actionText1 = '';

  Map<GlobalObjectKey, double> _headerHeightMap = {};

  Map<GlobalObjectKey, double> get headerHeightMap => _headerHeightMap;

  }

class TestModel2 extends ChangeNotifier {
  var controller = TextEditingController();
  var editText = '';
  var fruits = <String>['例)反則数'];

  void clearAdd() {
    this.fruits.add(editText);
    this.controller.clear();
    notifyListeners();
  }
}
