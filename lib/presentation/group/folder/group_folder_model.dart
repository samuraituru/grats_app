import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/domain/joingrouplist.dart';

class GroupFolderModel extends ChangeNotifier {
  final ScrollController? controller;

  GroupFolderModel(this.controller);

  List<Folder>? folders;
  Group? group;
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
    String folderID = doc.id;
    // Firestoreに追加
    await doc.set(
      {
        'folderName': folderName,
        'folderDescription': folderDescription,
        'folderID': folderID,
        'groupID': group?.groupID,
      },
    );
    notifyListeners();
  }

  Future<void> getFolder(Group group) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Folders')
        .where("groupID", isEqualTo: group.groupID)
        .get();
    snapshot.docs;

    final List<Folder> folders = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String folderName = data['folderName'];
      final String folderDescription = data['folderDescription'];
      return Folder(
          folderName: folderName, folderDescription: folderDescription);
    }).toList();
    this.folders = folders;
    notifyListeners();
  }
}
