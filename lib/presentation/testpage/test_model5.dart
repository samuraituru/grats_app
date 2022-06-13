import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/cursor.dart';
import 'package:grats_app/presentation/testpage/testpage5.dart';

class TestModel5 extends ChangeNotifier {
  //final bodyWidget = Body();
  List<Body> bodyList = [];

  createWidget() {
    //bodyList.add(bodyWidget);
    notifyListeners();
  }
  Cursor cursorRed1 = Cursor(x:30, y:100);
  var counterWidgets;
  List<Widget>? cursorList;

  TestModel5(){
    counterWidgets = createList();
  }
  void createWidget2(){
    counterWidgets.add(createListwidget);
    notifyListeners();
  }


  void changePoint(Cursor cursor, double dx, double dy) {
    cursor.x += dx;
    cursor.y += dy;
    notifyListeners();
  }

  List<Widget> createList() {
    final cursorList = <Widget>[
      movingCursor(cursorRed1, Colors.red)
    ];
    return cursorList;
  }
  QuerySnapshot? allJoinGroupsDoc;
  Widget movingCursor(Cursor cursor, Color color) {
    return Positioned(
      top: cursor.y,
      left: cursor.x,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          changePoint(cursor, details.delta.dx, details.delta.dy);
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 30,
          width: 30,
        ),
      ),
    );
  }

  Widget createListwidget() {
    final cursor = movingCursor(cursorRed1, Colors.red);
    return cursor;
  }
}
