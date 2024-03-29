import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grats_app/domain/cursor.dart';
import 'package:grats_app/domain/item.dart';
import 'package:grats_app/domain/objectboxFolder.dart';
import 'package:grats_app/domain/objectboxitem.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/objectbox.g.dart';
import 'package:grats_app/presentation/movie/browser/movewidget.dart';
import 'package:grats_app/presentation/movie/browser/movingwidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieBrowserModel extends ChangeNotifier {
  bool searchBoolean = false;
  Color selectColor = Colors.lightBlue;
  List<String> _list = [
    'English Textbook',
    'Japanese Textbook',
    'English Vocabulary',
    'Japanese Vocabulary'
  ];
  final countItemNameController = TextEditingController();
  final scrollController = ScrollController();

  final folderBox = store.box<objectboxFolder>();
  final itemBox = store.box<objectboxItem>();

  WebViewController? webController;
  final Completer<WebViewController> webViewController =
      Completer<WebViewController>();
  List<Item> countItems = <Item>[];
  Item? countItem;
  MoveWidget? testCountItem;
  List<MovingWidget> WidgetList = [];
  List<MoveWidget> testBodyList = [];
  Cursor? cursor;
  MovingWidget? movingList;
  MoveWidget? testBody;
  int? folderID;

  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    List<DropdownMenuItem<String>> folder = folderBox.getAll().map(
          (box) {
        folderList.add(box.floderName!);
        //print(model.folderList);
        return DropdownMenuItem(
          child: Text('${box.floderName}'),
          value: '${box.floderName}',
        );
      },
    ).toList();

    List<objectboxItem> itemBoxList = folderBox.getAll().map(
          (box) {
        return objectboxItem(
          itemName: box.floderName,
          itemDescription: box.floderDescription,
          folderID: box.id,
        );
      },
    ).toList();
    this.itemBoxList = itemBoxList;
  }

  Future<void> countItemDelete(int index) async {
    await countItems.removeAt(index);
    notifyListeners();
  }

  bodyListdelete(int index) {
    WidgetList.removeAt(index);
    notifyListeners();
  }

  initState2() {
    this.movingList = WidgetCreate();
    this.cursor = Cursor(x: 30, y: 100);
  }

  panUpdate(DragUpdateDetails details, Cursor cursor) {
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

  void changeColor(Item countItem,Color color) {
    countItem.color = color;
    notifyListeners();
  }

  void updateText(Item countItem) {
    countItem.title = editTitle;
    notifyListeners();
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
    if (countItemNameController.text == null || countItemNameController.text == ''){
      throw '項目名を入力してください';
    }
      countItems.add(Item(title: title));
      countItemNameController.clear();

      //final bodyWidget = MovingWidget(countItem: countItem);
      notifyListeners();
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
  String? newUrl;

  Widget searchTextField() {
    return TextField(
      onChanged: (String newUrl) {
        this.newUrl = newUrl;
        /*tfTap();
        for (int i = 0; i < _list.length; i++) {
          if (_list[i].contains(s)) {
            searchIndexList.add(i);
          }
        }*/
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
 void searchAction(){
    if (newUrl != null){
      webController?.loadUrl('https://www.google.com/search?q=${newUrl}');
    }
  }

  Widget searchListView() {
    return ListView.builder(
        itemCount: searchIndexList.length,
        itemBuilder: (context, index) {
          index = searchIndexList[index];
          return Card(child: ListTile(title: Text(_list[index])));
        });
  }
  void outPutAction() async {
    if (countItems == null) {
      throw 'カウントアイテムがありません';
    }
    //Dropdownで選択したフォルダ名でobjectboxFolderを取得する
    final objectboxFolderQuery = await (folderBox
        .query(objectboxFolder_.floderName.equals(isSelectedItem!)))
        .build();

    final queryFolder = await objectboxFolderQuery.find();

    //取得したobjectboxFolderからBoxIDを取得し代入する
    this.folderID = await queryFolder[0].id;
    objectboxFolderQuery.close();

    //画面上でカウントした項目をitemBoxへ追加する
    print(folderID);
    if (folderID != null && countItems != null) {
      for (Item item in countItems) {
        var title = item.title;
        var counter = item.counter.toString();
        this.outPutItem = objectboxItem(
          itemName: title,
          itemDescription: counter,
          folderID: folderID,
        );
        itemBox.put(outPutItem!);
      }
    }

    notifyListeners();
  }

  String? isSelectedItem = '選択する';
  List<String> folderList = ['選択する'];
  List<objectboxItem>? itemBoxList;
  objectboxItem? outPutItem;
}
