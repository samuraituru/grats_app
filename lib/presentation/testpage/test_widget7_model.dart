import 'package:flutter/material.dart';
import 'package:grats_app/domain/item.dart';
import 'package:grats_app/presentation/movie/browser/movewidget.dart';

class TestWidet7Model extends ChangeNotifier {
  Color selectColor = Colors.lightBlue;

  final texteditingcontroller = TextEditingController();
  final scrollController = ScrollController();

  List<MoveWidget> testBodyList = [];
  MoveWidget? moveWidget;

  testInitState() {
    final moveWidget = MoveWidget();
    //final moveList = MoveWidget();
    this.moveWidget = moveWidget;
    //this.testBody = testWidgetCreate();
  }

  testPanUpdate(DragUpdateDetails details) {
    moveWidget?.cursor.x += details.delta.dx;
    moveWidget?.cursor.y += details.delta.dy;
    notifyListeners();
  }

  List<int> searchIndexList = [];
  var position = Offset(10, 10);
  var dragUpdateDetails;

  final List<Widget> widgets = [];
  var contentWidgets;
  List<Widget>? listshot;
  Widget? widiwid;
  String title = '';
  String editTitle = '';

  void changeColor(Item countItem) {
    countItem.color = selectColor;
    notifyListeners();
  }

  void updateText(Item countItem) {
    countItem.title = editTitle;
  }

  void testIncrement() {
    moveWidget?.cursor.counter += 1;
    notifyListeners();
  }

  void itemCountdecrement(Item countItem) {
    if (countItem.counter > 0) {
      countItem.counter -= 1;
      notifyListeners();
    }
  }

  int moveIncrement(int counter) {
    counter += 1;
    return counter;
    notifyListeners();
  }

  void moveDecrement() {
    //if (testBody!.counter > 0) testBody?.counter -= 1;
    notifyListeners();
  }

  void testCountItemCreate() {
    if (title != null) {
      moveWidget?.cursor.title = title;
      this.moveWidget = moveWidget;
      texteditingcontroller.clear();

      testBodyList.add(moveWidget!);
      notifyListeners();
    }
  }
  void testCountItemCreate2(moveWidget) {
    if (title != null) {
      moveWidget?.cursor.title = title;
      //this.moveWidget = moveWidget;
      texteditingcontroller.clear();

      testBodyList.add(moveWidget!);
      notifyListeners();
    }
  }

  void countItemCreate() {
    if (title != null) {
      //countItems.add(Item(title: title));
      texteditingcontroller.clear();

      //final bodyWidget = MovingWidget(countItem: countItem);
      //bodyList.add(movingList!);
      notifyListeners();
    }
  }

  MoveWidget testWidgetCreate() {
    final moveList = MoveWidget();
    return moveList;
  }

  void bodyListDelete(int index) {
    testBodyList.removeAt(index);
    notifyListeners();
  }
}
