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
      final String gDesc = data['gDesc'];
      final String gName = data['gName'];
      return Groups(gDesc, gName);
    }).toList();
    this.groups = groups;
    notifyListeners();
  }

}

