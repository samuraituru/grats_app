import 'package:flutter/material.dart';
import 'package:grats_app/domain/cursor.dart';
import 'package:grats_app/domain/item.dart';
import 'package:grats_app/presentation/movie/browser/movewidget.dart';
import 'package:grats_app/presentation/movie/browser/movingwidget.dart';

class MovieBrowserModel extends ChangeNotifier {
  bool searchBoolean = false;
  Color selectColor = Colors.lightBlue;
  List<String> _list = [
    'English Textbook',
    'Japanese Textbook',
    'English Vocabulary',
    'Japanese Vocabulary'
  ];
  final texteditingcontroller = TextEditingController();
  final scrollController = ScrollController();
  final countItems = <Item>[];
  Item? countItem;
  MoveWidget? testCountItem;
  List<MovingWidget> WidgetList = [];
  List<MoveWidget> testBodyList = [];
  Cursor? cursor;
  MovingWidget? movingList;
  MoveWidget? testBody;

  countItemDelete(int index) {
    countItems.removeAt(index);
    notifyListeners();
  }

  bodyListdelete(int index) {
    WidgetList.removeAt(index);
    notifyListeners();
  }

  initState() {
    this.movingList = WidgetCreate();
    this.cursor = Cursor(x: 30, y: 100);
  }

  panUpdate(DragUpdateDetails details,Cursor cursor) {
    cursor.x += details.delta.dx;
    cursor.y += details.delta.dy;
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

  void itemCountIncrement(Item countItem) {
    countItem.counter += 1;
    movingList?.corsor.counter++;
    notifyListeners();
  }

  void bodyListIncrement() {
    movingList?.corsor.counter += 1;
    //bodyWidget. += 1;
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

  void countItemCreate() {
    if (title != null) {
      countItems.add(Item(title: title));
      texteditingcontroller.clear();

      //final bodyWidget = MovingWidget(countItem: countItem);
      WidgetList.add(movingList!);
      notifyListeners();
    }
  }

  MovingWidget WidgetCreate() {
    final bodyWidget = MovingWidget(countItem: countItem);
    return bodyWidget;
  }

  void searchPush() {
    this.searchBoolean = true;
    notifyListeners();
  }

  void searchPull() {
    this.searchBoolean = false;
    notifyListeners();
  }

  void tfTap() {
    this.searchIndexList = [];
    notifyListeners();
  }

  var controller = TextEditingController();
  var actionText = '';
  var action = <String>['例)反則数（長押しで削除）'];

  Widget searchTextField() {
    return TextField(
      onChanged: (String s) {
        tfTap();
        for (int i = 0; i < _list.length; i++) {
          if (_list[i].contains(s)) {
            searchIndexList.add(i);
          }
        }
      },
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget searchListView() {
    return ListView.builder(
        itemCount: searchIndexList.length,
        itemBuilder: (context, index) {
          index = searchIndexList[index];
          return Card(child: ListTile(title: Text(_list[index])));
        });
  }
}
