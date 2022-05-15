import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/groups.dart';

class GroupFolderModel extends ChangeNotifier {
  final ScrollController? controller;

  GroupFolderModel(this.controller);

  List<Groups>? groups;
  String groupname = '';
  List<Folders>? folders;

  Future getGroups() async {
    final QuerySnapshot snapshot1 =
        await FirebaseFirestore.instance.collection('Groups').get();

    final List<Groups> groups = await snapshot1.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String groupDesc = data['groupDesc'];
      final String groupname = data['groupname'];
      this.groupname = groupname;
      return Groups(groupDesc, groupname);
    }).toList();

    this.groups = groups;
    notifyListeners();
  }
  Future getFolder() async {
    final QuerySnapshot snapshot2 = await FirebaseFirestore.instance
        .collection('Groups')
        .doc('folders')
        .collection('fldname')
        .get();

    final List<Folders> folders = snapshot2.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String foldername = data['foldername'];
      return Folders(foldername);

    }).toList();

    this.folders = folders;
    notifyListeners();
  }
}
