import 'package:flutter/material.dart';
import 'package:grats_app/domain/countitem.dart';

class MovieLocalModel extends ChangeNotifier {
  var controller = TextEditingController();
  var scrollController = ScrollController();
  var inputText = '';
  var inputTextList = <String>['例)'];
  int index = 0;
  CountWidget countWidget = CountWidget();

  Future addItem() async {
    //this.inputTextList.add(inputText);
    countWidget.setList = await inputText;
    //countWidget.setTitle = await inputText;
    notifyListeners();
  }
  void addIndex() {
    countWidget.countIndex = ++countWidget.countIndex;
    notifyListeners();
  }

  void clearItem() {
    this.controller.clear();
    this.inputText = '';
    notifyListeners();
  }
  CollText(){
    CountWidget countWidget = CountWidget();
    print('localは${countWidget.countTitle}');
  }

  void outputMap(){
    Map<String, String> outputMap = {};
    outputMap['item'] = '${countWidget.countItemList}';
    outputMap['counter'] = '${countWidget.counter}';
    outputMap['index'] = '0';
  }
}
