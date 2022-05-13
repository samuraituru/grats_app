import 'package:flutter/material.dart';

class MovieLocalModel extends ChangeNotifier {
  var controller = TextEditingController();
  var actionText = '';
  var action = <String>['例)反則数（長押しで削除）'];

  void actionClearAdd() {
    this.action.add(actionText);
    this.controller.clear();
    notifyListeners();
  }
}

