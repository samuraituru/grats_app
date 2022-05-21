import 'package:flutter/material.dart';

class ActionWidgetModel extends ChangeNotifier {
  int counter = 0;

  void increment(){
    counter = ++counter;
    notifyListeners();
  }
  void decrement(){
    counter = --counter;
    notifyListeners();
  }

  var texteditingcontroller = TextEditingController();
  var scrollController = ScrollController();
  List<String> changetextlist = [];
  List<String> completetextlist = [];
  Color selectcolor = Colors.lightBlue;

  colorChanged(color){
    //this.activecolor = color.add(color);
    this.selectcolor = color;
    notifyListeners();
  }
  updateList(){
    this.completetextlist = changetextlist;
    notifyListeners();
  }

  colorPicker() {
    pickerColor: Colors.red; //default color
    onColorChanged: (Color color){ //on color picked
      print(color);
    };
  }

  String createtext = '';
}