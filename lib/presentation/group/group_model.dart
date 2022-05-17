import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grats_app/domain/groups.dart';

class GroupModel extends ChangeNotifier {
  var controller = TextEditingController();
  var editText = '';
  var fruits = <String>['例)反則数'];

  void clearAdd() {
    this.fruits.add(editText);
    this.controller.clear();
    notifyListeners();
  }
  String? addgroup;
  QuerySnapshot? snapshot1;

  addDlgName(addgroups) {
    String addgroup = '';
    this.addgroup = addgroups;
  }

  List<Groups>? groups;

  Future getGroups() async {
    final QuerySnapshot snapshot1 =
        await FirebaseFirestore.instance.collection('Groups').get();
    this.snapshot1 = snapshot1;

    final List<Groups> groups = snapshot1.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String gName = data['gName'];
      final String gDesc = data['gDesc'];
      return Groups(gName, gDesc);
    }).toList();
    this.groups = groups;
    notifyListeners();
  }

  String? gName;
  String? gDesc;
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addBook() async {
    if (gName == null || gName == "") {
      throw 'グループ名が入力されていません';
    }

    if (gDesc == null || gDesc!.isEmpty) {
      throw '説明が入力されていません';
    }

    final doc = FirebaseFirestore.instance.collection('books').doc();


    // firestoreに追加
    await doc.set({
      'title': gName,
      'author': gDesc,
    });
  }

}

