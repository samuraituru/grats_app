import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/domain/joingrouplist.dart';

class GroupFolderModel extends ChangeNotifier {
  final ScrollController? controller;
  GroupFolderModel(this.controller);

  List<Folder>? folders;
  JoinGroup? joinGroup;
  String folderName = '';
  String folderDescription = '';

  Future addFolder() async {
    if (folderName == null || folderName == "") {
      throw 'フォルダ名が入力されていません';
    }
    if (folderDescription == null || folderDescription.isEmpty) {
      throw '説明が入力されていません';
    }
    final doc = FirebaseFirestore.instance.collection('Folders').doc();
    //Folder-IDを取得
    var addFolderID = doc.id;
    // Firestoreに追加
    await doc.set(
      {
        'folderName': folderName,
        'folderDescription': folderDescription,
        'folderID': addFolderID,
        'groupID': joinGroup?.groupID,
      },
    );
    notifyListeners();
  }

  Future getFolder(JoinGroup joinGroup) async {
    final  snapshot = await FirebaseFirestore.instance
        .collection('Folders')
        .doc('${joinGroup.joinUserID}')
        .collection('Folders')
        .get();
    snapshot.docs;

    final List<Folder> folders = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String fName = data['fName'];
      final String fDesc = data['fDesc'];
      return Folder();
    }).toList();
    this.folders = folders;
    notifyListeners();
  }
}
