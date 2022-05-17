import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/groups.dart';

class GroupFolderModel extends ChangeNotifier {
  final ScrollController? controller;
  GroupFolderModel(this.controller);

  List<Folders>? folders;

  Future getGroups() async {
    notifyListeners();
  }

  Future getFolder() async {
    final QuerySnapshot snapshot2 = await FirebaseFirestore.instance
        .collection('Groups')
        .doc('Group')
        .collection('Folders')
        .get();

    final List<Folders> folders = snapshot2.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String fName = data['fName'];
      final String fDesc = data['fDesc'];
      return Folders(fName,fDesc);
    }).toList();
    this.folders = folders;
    notifyListeners();
  }
}
