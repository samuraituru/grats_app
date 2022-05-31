import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/groups.dart';

class GroupFolderModel extends ChangeNotifier {
  final ScrollController? controller;
  GroupFolderModel(this.controller);

  List<Folder>? folders;

  Future getGroups() async {
    notifyListeners();
  }

  Future getFolder() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Groups')
        .doc('Group')
        .collection('Folders')
        .get();

    final List<Folder> folders = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String fName = data['fName'];
      final String fDesc = data['fDesc'];
      return Folder(fName,fDesc);
    }).toList();
    this.folders = folders;
    notifyListeners();
  }
}
