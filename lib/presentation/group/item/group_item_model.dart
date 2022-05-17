import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/groups.dart';

class GroupItemModel extends ChangeNotifier {
  final ScrollController? controller;

//  final List<Items>? header = items;
  GroupItemModel(this.controller);

  List<Items>? items;

  Future getItems() async {
    final QuerySnapshot snapshot2 = await FirebaseFirestore.instance
        .collection('Groups')
        .doc('Group')
        .collection('Folders')
        .doc('Folder')
        .collection('Items')
        .get();

    final List<Items> items = snapshot2.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String iName1 = data['iName1'];
      final String iName2 = data['iName2'];
      return Items(iName1,iName2);
    }).toList();
    this.items = items;
    notifyListeners();
  }
}
