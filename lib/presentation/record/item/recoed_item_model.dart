import 'package:flutter/material.dart';
import 'package:grats_app/domain/objectboxitem.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/objectbox.g.dart';

class RecordItemModel extends ChangeNotifier {
  final itemBox = store.box<objectboxItem>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  objectboxItem? item;
  List<objectboxItem>? items;
  int? folderID;

  initAction(int folderID) {
    //folderIDがNullでない場合、queryを実行
    print(folderID);
    if (folderID != null) {
      final query =
          (itemBox.query(objectboxItem_.folderID.equals(folderID))).build();
      final results = query.find();
      this.items = results;
      query.close();
      this.folderID = folderID;
      notifyListeners();
    }
  }

  void putItem() {
    if (nameController.text == null || nameController.text == "") {
      throw 'アイテム名が入力されていません';
    }
    if (descriptionController.text == null ||
        descriptionController.text.isEmpty) {
      throw '説明が入力されていません';
    }
    final item = objectboxItem(
        itemName: nameController.text,
        itemDescription: descriptionController.text,
        folderID: folderID);
    itemBox.put(item);
    notifyListeners();
    nameController.clear();
    descriptionController.clear();
    initAction(folderID!);
  }

  void fetchUser() {
    notifyListeners();
  }

  void getItem(String itemID) {
    if (itemID != null) {
      final int? userId = int.tryParse('${itemID}');
      final objectboxItem? item = itemBox.get(userId!);
      this.item = item;
      print('${item?.itemName}');
      nameController.clear();
    }
    setBox();
  }

  void setBox() {
    items?.add(item!);
  }

  void remove() {
    final int? userId = int.tryParse('${nameController.text}');
    itemBox.remove(userId!);
    notifyListeners();
  }

  void allRemove() {
    itemBox.removeAll();
    notifyListeners();
  }

  void userCount() {
    final userCount = itemBox.count();
    print('${userCount}');
  }

  List<ListTile> fetchItem() {
    List<ListTile> item = itemBox
        .getAll()
        .map(
          (item) => ListTile(
            leading: Text('${item.itemName ?? '名前無し'}'),
            title: Text('${item.itemDescription}'),
          ),
        )
        .toList();
    return item;
  }
}
