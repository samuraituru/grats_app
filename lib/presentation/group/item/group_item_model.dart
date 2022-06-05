import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/record.dart';

class GroupItemModel extends ChangeNotifier {
  final ScrollController? controller;

//  final List<Items>? header = items;
  GroupItemModel(this.controller);

  List<Record>? records;

  Future getRecord() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Groups')
        .doc('Group')
        .collection('Folders')
        .doc('Folder')
        .collection('Items')
        .get();

    final List<Record> records = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String title = data['title'];
      final String contents = data['contents'];
      return Record(title:title,contents:contents, headerName: '', folderID: '', groupID: '');
    }).toList();
    this.records = records;
    notifyListeners();
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
