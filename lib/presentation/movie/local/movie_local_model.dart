import 'package:flutter/material.dart';
import 'package:grats_app/domain/countitem.dart';
import 'package:grats_app/domain/item.dart';
import 'package:grats_app/domain/objectboxFolder.dart';
import 'package:grats_app/domain/objectboxitem.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/objectbox.g.dart';

class MovieLocalModel extends ChangeNotifier {
  final countItemNameController = TextEditingController();
  final itemNameController = TextEditingController();
  final scrollController = ScrollController();
  String editTitle = '';
  int counter = 0;
  Color selectColor = Colors.lightBlue;
  final folderBox = store.box<objectboxFolder>();
  final itemBox = store.box<objectboxItem>();
  String? isSelectedItem = '選択する';
  List<String> folderList = ['選択する'];
  List<String> dropItem = [];

  List<Item> countItems = <Item>[];

  void countItemCreate() {
    if (countItemNameController.text == null || countItemNameController.text == '') {
      throw '項目名を入力してください';
    }
      countItems.add(Item(title: countItemNameController.text));
      this.countItemNameController.clear();
      notifyListeners();
    countItemNameController.clear();
  }

  void initState() {
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

  int? folderID;

  void outPutAction() async {
    if (itemNameController.text == null || itemNameController.text == ''){
      throw 'アイテム名がありません';
    }
    if (countItems == null) {
      throw 'カウントアイテムがありません';
    }
    if (isSelectedItem =='選択する'){
      throw '保存するフォルダを選択してください';
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
        var title = itemNameController.text;
        String itemDescription = descListAdd();
        this.outPutItem = objectboxItem(
          itemName: title,
          itemDescription: itemDescription,
          folderID: folderID,
        );
        itemBox.put(outPutItem!);
    }

    notifyListeners();
  }
  List<String> descriptionList = [];

  String descListAdd() {
    var descriptionList = countItems.map((countItem) {
      return '${countItem.title}:${countItem.counter.toString()}\n';
    }).toList();

    String name = descriptionList.join();
/*    for (int i = 0; i < countItems.length; i++){
      descriptionList.add('${countItem.title}${countItem.counter.toString()}\n');
    }*/

    print(name);
    return name;
  }

  objectboxItem? outPutItem;

  List<objectboxItem>? itemBoxList;

  void increment(Item countItem) {
    countItem.counter += 1;
    notifyListeners();
  }

  void decrement(Item countItem) {
    if (countItem.counter > 0) countItem.counter -= 1;
    notifyListeners();
  }

  void changeColor(Item countItem) {
    countItem.color = selectColor;
    notifyListeners();
  }

  void updateText(Item countItem) {
    countItem.title = editTitle;
    notifyListeners();
  }

/*  Widget outPutText() {
    if (!countItems.isEmpty) {
      {
        for (var i = 0; i < countItems.length; i++)
        return Text(
            '${countItems[0]}\n${counter}');
      }
    } else {
      return const Text('項目なし');
    }
  }*/

/*Future listOutput() async {
    for (int i = 0; i < countItemList.length; i++) {
      countMap = {
        '${countItemList[i]}': '${counterList[i]}',
      };
    }
    notifyListeners();
  }*/
}

DropdownMenuItem DropItem(String e) {
  return DropdownMenuItem(
    child: Text('$e'),
    value: '$e',
  );
}
