import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/groups.dart';
import 'package:grats_app/domain/record.dart';

class GroupModel extends ChangeNotifier {
  var controller = TextEditingController();
  var editText = '';
  var fruits = <String>['例)反則数'];
  var foloders = <Folder>[];
  var records = <Record>[];
  var groups = <Group>[];
  //final groups = <Group>[];

  String? addgroup;
  QuerySnapshot? snapshot;

  Future getGroup() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Groups').get();
    this.snapshot = snapshot;

    final List<Group> groups = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String gName = data['gName'];
      final String gDesc = data['gDesc'];
      final String gID = data['gID'];
      return Group(gName:gName, gDesc:gDesc, gID:gID);
    }).toList();
    this.groups = groups;
    notifyListeners();
  }

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addGroup(Group group) async {
    if (group.gName == null || group.gName == "") {
      throw 'グループ名が入力されていません';
    }

    if (group.gDesc == null || group.gDesc!.isEmpty) {
      throw '説明が入力されていません';
    }

    final doc = FirebaseFirestore.instance.collection('Groups').doc();

    // firestoreに追加
    await doc.set({
      'name': group.gName,
      'description': group.gDesc,
    });
  }
  Future addRecord(Record record) async {
    if (record.title == null || record.title == "") {
      throw 'レコード名が入力されていません';
    }

    final doc = FirebaseFirestore.instance.collection('Records').doc();

    // firestoreにrecordを追加
    await doc.set({
      'title': record.title,
      'contents': record.contents,

    });
  }

}

