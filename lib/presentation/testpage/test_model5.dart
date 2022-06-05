import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/joingrouplist.dart';

class TestModel5 extends ChangeNotifier {
  final joinGroupInfo = <String, dynamic>{
    "joinUserID": "11111",
    "groupName": 'Flutter大学'
  };

  JoinGroup? joinGroups;
  QuerySnapshot? allJoinGroupsDoc;

  Future<void> TestWhere() async {
/*final GroupsDoc =
    FirebaseFirestore.instance
        .collection('AllJoinGroups');
GroupsDoc.doc("joinGroupInfo").set(joinGroupInfo);*/

    final QuerySnapshot allJoinGroupsDoc = await FirebaseFirestore.instance
        .collection('AllJoinGroups')
        .where("joinUserID", isEqualTo: "00000")
        .get();
    this.allJoinGroupsDoc = allJoinGroupsDoc;
    print('allJoin中身は${allJoinGroupsDoc.docs}');
  }
}
