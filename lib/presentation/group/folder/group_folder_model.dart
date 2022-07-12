import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/domain/joingrouplist.dart';

class GroupFolderModel extends ChangeNotifier {
  TextEditingController folderNameController = TextEditingController();
  TextEditingController folderDescController = TextEditingController();

  List<Folder>? folders;
  //Group? group;
  String folderName = '';
  String folderDescription = '';

  void controllerClear() {
    folderNameController.clear();
    folderDescController.clear();
  }

  Future<void> addFolder(Group group) async {
    if (folderNameController.text == null || folderNameController.text == "") {
      throw 'フォルダ名が入力されていません';
    }
    if (folderDescController.text == null ||
        folderDescController.text.isEmpty) {
      throw '説明が入力されていません';
    }
    final foldersDoc = await FirebaseFirestore.instance.collection('Folders').doc();
    //Folder-IDを取得
    String folderID = foldersDoc.id;
    // Firestoreに追加
    await foldersDoc.set(
      {
        'folderName': folderNameController.text,
        'folderDescription': folderDescController.text,
        'folderID': folderID,
        'groupID': group.groupID,
      },
    );
    notifyListeners();
  }

  Future<void> updateFolder(Folder folder) async {
    if (folderNameController.text == null && folderNameController.text == ''){
      throw 'フォルダ名を入力してください';
    }
    if (folderDescController.text == null && folderDescController.text == ''){
      throw '説明を入力してください';
    }

    if (folderNameController.text != null ||
        folderDescController.text != null) {
      final foldersDoc = await FirebaseFirestore.instance
          .collection('Folders')
          .doc(folder.folderID);

      // Firestoreの値を更新する
      await foldersDoc.update(
        {
          'folderName': folderNameCheck(folder),
          'folderDescription': folderDescriptionCheck(folder),
        },
      );
    }
  }

  String folderNameCheck(Folder folder) {
    if (folderNameController.text == '') {
      return folder.folderName!;
    }
    return folderNameController.text;
  }

  String folderDescriptionCheck(Folder folder) {
    if (folderDescController.text == '') {
      return folder.folderDescription!;
    }
    return folderDescController.text;
  }

  Future<void> fetchFolder(Group group) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Folders')
        .where("groupID", isEqualTo: group.groupID)
        .get();
    snapshot.docs;

    final List<Folder> folders = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final folderName = data['folderName'] as String;
      final folderDescription = data['folderDescription'] as String;
      final folderID = data['folderID'] as String?;
      final groupID = data['groupID'] as String;
      return Folder(
          folderName: folderName,
          folderDescription: folderDescription,
          folderID: folderID,
          groupID: groupID);
    }).toList();
    this.folders = folders;
    notifyListeners();
  }

  Future<void> foldersDocDelete(Folder folder) async{
    FirebaseFirestore.instance.collection('Folders').doc(folder.folderID).delete();
  }
}
