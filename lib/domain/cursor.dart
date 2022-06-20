import 'dart:ui';
import 'package:flutter/material.dart';

class Cursor {
  double x = 0.0;
  double y = 0.0;
  int counter;
  String? title;
  Color? color = Colors.lightBlue;
  int? itemIndex;

  Cursor({required this.x, required this.y, this.counter= 0});
}
