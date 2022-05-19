import 'package:flutter/material.dart';

class MovieBrowserModel extends ChangeNotifier {
  bool searchBoolean = false;
  List<String> _list = [
    'English Textbook',
    'Japanese Textbook',
    'English Vocabulary',
    'Japanese Vocabulary'
  ];
  List<int> searchIndexList = [];

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
