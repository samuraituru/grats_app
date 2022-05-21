import 'package:flutter/material.dart';

class MovieLocalModel extends ChangeNotifier {
  var controller = TextEditingController();
  var scrollController = ScrollController();
  var inputText = '';
  var inputtextlist = <String>['例)反則数'];

  void actionClearAdd() {
    this.inputtextlist.add(inputText);
    this.controller.clear();
    this.inputText = '';
    notifyListeners();
  }
}
