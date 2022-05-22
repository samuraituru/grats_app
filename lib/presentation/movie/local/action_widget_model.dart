import 'package:flutter/material.dart';
import 'package:grats_app/domain/countitem.dart';

class ActionWidgetModel extends ChangeNotifier {
  CountWidget countWidget = CountWidget();

  int counter = 0;

  void increment(){
    counter = ++counter;
    notifyListeners();
  }
  void decrement(){
    if (counter>0){
      counter = --counter;
      notifyListeners();
    }
  }
  String changetext = '';

  CollText(){
    CountWidget countWidget = CountWidget();
    print('actionは${countWidget.countTitle}');
  }

  var texteditingcontroller = TextEditingController();
  var scrollController = ScrollController();
  List<String> changetextlist = [];
  List<String> completetextlist = [];
  Color selectcolor = Colors.lightBlue;

  changeColor(color){
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
  var outputlist = <String, String>{};

  listOutput(){
    this.outputlist = {'title': '24', 'index': '18', 'counter': '0'};
  }
}