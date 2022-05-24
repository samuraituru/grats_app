import 'package:flutter/material.dart';
import 'package:grats_app/domain/countitem.dart';

class MovieLocalModel extends ChangeNotifier {
  var texteditingcontroller = TextEditingController();
  var scrollController = ScrollController();

  var inputText = '';
  var countItem = '例)';
  int index = 0;
  var inputTextList = <String>[''];
  List<String> countItemList = [];

  //CountWidget countWidget = CountWidget();

  void addItem() {
    //this.inputTextList.add(inputText);
    countItemList.add(inputText);
    //this.countItem = inputText;
    notifyListeners();
  }

  void addIndex() {
    index++;
    notifyListeners();
  }

  void clearItem() {
    this.texteditingcontroller.clear();
    this.inputText = '';
    notifyListeners();
  }

  CollText() {
    CountWidget countWidget = CountWidget();
    print('localは${countWidget.countTitle}');
  }

  void outputMap() {
    Map<String, String> outputMap = {};
    //outputMap['item'] = '${countWidget.countItemList}';
    //outputMap['counter'] = '${countWidget.counter}';
    //outputMap['index'] = '0';
  }

  List<int> counterList = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  incrementList() async {
    counterList[index] = await counter;
    notifyListeners();
  }

  void decrementList() {
    if (counter >= 0) {
      counterList[index] = counter;
      notifyListeners();
    }
  }

  int counter = 0;

  void increment() {
    counter = ++counter;
    notifyListeners();
  }

  void decrement() {
    if (counter > 0) {
      counter = --counter;
      notifyListeners();
    }
  }

  String changetext = '';

  //List<String> changetextlist = [];
  String completetext = '';
  Color selectColor = Colors.lightBlue;

  changeColor(color) {
    //this.activecolor = color.add(color);
    this.selectColor = color;
    notifyListeners();
  }

  updateList() {
    this.completetext = changetext;
    notifyListeners();
  }

  colorPicker() {
    pickerColor:
    Colors.red; //default color
    onColorChanged:
    (Color color) {
      //on color picked
      print(color);
    };
  }

  colorReset() {
    this.counter = 0;
    this.selectColor = Colors.lightBlue;
  }

  mapGet() {
    return countMap;
  }

  var countMap = <String, String>{};

 Future listOutput() async {
    for (int i = 0; i < countItemList.length; i++) {
      countMap = {
        '${countItemList[i]}': '${counterList[i]}',
      };
    }
    notifyListeners();
  }
}
