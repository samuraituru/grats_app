import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/item2.dart';

class GroupItemModel extends ChangeNotifier {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescController = TextEditingController();
  void controllerClear() {
    itemNameController.clear();
    itemDescController.clear();
  }

  List<Item2>? items;
  String itemName = '';
  String itemDescription = '';

  Future<void> getItem(Folder folder) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Items')
        .where("folderID", isEqualTo: folder.folderID)
        .get();

    final List<Item2> items = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final itemName = data['itemName'] as String;
      final itemDescription = data['itemDescription'] as String?;
      final itemID = data['itemID'] as String?;
      return Item2(
          itemName: itemName,
          itemDescription: itemDescription,
          itemID: itemID);
    }).toList();

    this.items = items;
    notifyListeners();
  }

  Future<void> setItem(Folder folder) async {
    if (itemNameController.text == null || itemNameController.text == "") {
      throw 'アイテム名が入力されていません';
    }
    if (itemDescController.text == null || itemDescController.text == "") {
      throw '説明が入力されていません';
    }

    final itemsDoc = await FirebaseFirestore.instance.collection('Items').doc();

    //Folder-IDを取得
    String itemID = itemsDoc.id;

    // Firestoreにrecordを追加
    await itemsDoc.set({
      'itemName': itemNameController.text,
      'itemDescription': itemDescController.text,
      'itemID': itemID,
      'folderID': folder.folderID,
    });
  }
  Future<void> itemDocDelete(int index) async{
   final id = items![index].itemID;
    FirebaseFirestore.instance.collection('Items').doc(id).delete();
  }

}
