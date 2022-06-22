import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/item2.dart';
import 'package:grats_app/domain/record.dart';

class GroupItemModel extends ChangeNotifier {
  final ScrollController? controller;

//  final List<Items>? header = items;
  GroupItemModel(this.controller);

  List<Item2>? items;
  String itemName = '';
  String itemDescription = '';

  Future<void> getItem(Folder folder) async {
    final  snapshot = await FirebaseFirestore.instance
        .collection('Items')
        .where("folderID", isEqualTo: folder.folderID)
        .get();

    final List<Item2> items = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String itemName = data['itemName'];
      final String itemDescription = data['itemDescription'];
      return Item2(itemName:itemName,itemDescription:itemDescription);
    }).toList();
    this.items = items;
    notifyListeners();
  }


  Future setItem() async {
    if (itemName == null || itemName == "") {
      throw 'アイテム名が入力されていません';
    }

    final doc = FirebaseFirestore.instance.collection('Items').doc();

    // Firestoreにrecordを追加
    await doc.set({
      'itemName': itemName,
      'itemDescription': itemDescription,
    });
  }
}
