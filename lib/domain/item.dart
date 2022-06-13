import 'package:flutter/material.dart';

class Item {
  String title;
  int counter;
  Color color;
  int? itemIndex;

  Item(
      {required this.title,
        this.counter = 0,
        this.color = Colors.lightBlue,
        this.itemIndex});
}
