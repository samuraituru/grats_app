import 'package:flutter/material.dart';

class MovieLocalModel extends ChangeNotifier {
  var controller = TextEditingController();
  var scrollController = ScrollController();
  var actionText = '';
  var action = <String>['例)反則数'];
  Color mycolor = Colors.lightBlue;
  var actcolor = <Color>[];

  void actionClearAdd() {
    this.action.add(actionText);
    this.controller.clear();
    notifyListeners();
  }
  void colorChanged(color) {
    this.actcolor = color.add(color);
    notifyListeners();
  }

  colorPicker() {
      pickerColor: Colors.red; //default color
      onColorChanged: (Color color){ //on color picked
        print(color);
      };
  }
}
