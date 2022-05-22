import 'package:flutter/material.dart';

class CountWidget {

  List<String> _countItemList = [];
  int countIndex = 0;
  String _countTitle = '例)反則数';
  Color _countColor = Colors.lightBlue;
  int _counter = 0;

  //CountWidget(this._countTitle, this._countColor, this._counter);

  List<String> get countItemList => _countItemList;
  //int get countIndex => _countIndex;
  String get countTitle => _countTitle;
  Color get countColor => _countColor;
  int get counter => _counter;

  set setList(String s) {
    if (s != null) {
      _countItemList.add(s);
    } else {
      print('$s:空白です。');
    }
  }

  set setIndex(int i) {
    countIndex = i;
  }

  set setTitle(String s) {
    if (s.length > 0 && s.length < 15) {
      _countTitle = s;
    } else {
      print('$s:文字数を1文字以上15文字以下にしてください。');
    }
  }
}
class SelectColor {
  Color color = Colors.lightBlue;

  SelectColor(Color color) {
    this.color = color;
  }
}

class ItemCounter {
  int counter = 0;

  ItemCounter(int counter) {
    this.counter = counter;
  }
}
