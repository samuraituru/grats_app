import 'package:flutter/material.dart';
import 'package:grats_app/domain/cursor.dart';
import 'package:grats_app/domain/item.dart';

class MovieBrowserModel extends ChangeNotifier {
  bool searchBoolean = false;
  List<String> _list = [
    'English Textbook',
    'Japanese Textbook',
    'English Vocabulary',
    'Japanese Vocabulary'
  ];
  final texteditingcontroller = TextEditingController();
  final scrollController = ScrollController();
  var countItems = <Item>[];

  List<int> searchIndexList = [];
  var position = Offset(10, 10);
  var dragUpdateDetails;

  final List<Widget> widgets  = [];
  var contentWidgets;
  List<Widget>? listshot;
  Widget? widiwid;
  String title = '';
  String editTitle = '';

  void countItemCreate() {
    if (title != null) {
      countItems.add(Item(title: title));
      this.texteditingcontroller.clear();
      notifyListeners();
    }
  }

  dragUpdate(dragUpdateDetails){
    widgets.add(dragUpdateDetails);
  }

  movePosition(localPosition){
    this.position = localPosition;
    notifyListeners();
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

  void actionClearAdd() {
    this.action.add(actionText);
    this.controller.clear();
    notifyListeners();
  }

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
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
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
