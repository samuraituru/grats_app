import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/domain/joingrouplist.dart';
import 'package:grats_app/domain/myuser.dart';
import 'package:grats_app/domain/record.dart';

class GroupModel extends ChangeNotifier {
  var controller = TextEditingController();
  var editText = '';
  var fruits = <String>['例)反則数'];
  var foloders = <Folder>[];
  var records = <Record>[];
  Group? groups;
  List<JoinGroup> joinGroups = [];
  String addGroupName = '';
  String addGroupDescription = '';
  MyUser myuser = MyUser();
  List<String> gIDList = [];
  String addGroupID = '';

  //final groups = <Group>[];
  String? uID;
  String? currentUID;
  String? gID;
  String? addgroup;
  QuerySnapshot? snapshot;
  DocumentSnapshot? docsnapshot;

  Future<void> newfetchGroup() async {
    User? currentuser = await FirebaseAuth.instance.currentUser;
    this.currentUID = currentuser?.uid.toString();

    final QuerySnapshot joinGroupsDoc = await FirebaseFirestore.instance
        .collection('AllJoinGroups')
        .where("joinUserID", isEqualTo: currentUID)
        .get();

    final List<JoinGroup> joins =
        await joinGroupsDoc.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String joinUserID = data['joinUserID'];
      final String groupID = data['groupID'];
      final String groupName = data['groupName'];
      final String groupDescription = data['groupDescription'];
      final String memberCounter = data['memberCounter'];
      return JoinGroup(
          joinUserID: joinUserID,
          groupID: groupID,
          groupName: groupName,
          groupDescription: groupDescription,
          memberCounter: memberCounter);
    }).toList();
    this.joinGroups = joins;
    print('joinGroupsの中身は${joinGroups}');
    notifyListeners();
  }

  Future<void> fetchGroup() async {
    User? currentuser = await FirebaseAuth.instance.currentUser;
    this.currentUID = currentuser?.uid.toString();
    //ログイン中かつグループMAPを持っている場合、UsersのDocを取得
    if (currentUID != null) {
      print('currentUIDは${currentUID}');
      final DocumentSnapshot userDocSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUID)
          .get();

      //UsersのDocからgIDListを取得
      final Map<String, dynamic>? data =
          userDocSnapshot.data() as Map<String, dynamic>?;
      final a = (data!['gIDList'] as List<dynamic>).map((e) => '$e').toList();
      this.gIDList = a;
      print('gIDListは${this.gIDList}');

      //gIDListの要素毎に、DocumentSnapshotを取得する
/*
      getgIDList = await gIDList?.map((gID) async {
        var doc = await FirebaseFirestore.instance.collection('Groups').doc('$gID').get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        final String menberID = data['uID'];
      }).toList();
*/
      for (final gID in gIDList) {
        print(gID);
/*
        var doc = await FirebaseFirestore.instance.collection('Groups').doc('$gID').get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        final String menberID = data['uID'];
*/
      }
      notifyListeners();
    }
  }

  Future getMyuser() async {
    final docsnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUID)
        .get();
    this.docsnapshot = docsnapshot;

    final Map<String, dynamic>? data = docsnapshot.data();
    myuser.gID = data!['gID'];
    notifyListeners();
  }


  Future getGroup() async {
    //ログインしている場合、グループを作成できる
    //

    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Groups').get();
    this.snapshot = snapshot;
    //this.gID = snapshot.id;

    final List<Group> groups = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String gName = data['gName'];
      final String gDesc = data['gDesc'];
      final String gID = data['gID'];
      return Group();
    }).toList();
    //this.groups = groups;
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

  Future addGroup() async {
    if (addGroupName == null || addGroupName == "") {
      throw 'グループ名が入力されていません';
    }
    if (addGroupDescription == null || addGroupDescription.isEmpty) {
      throw '説明が入力されていません';
    }
    final doc = FirebaseFirestore.instance.collection('Groups').doc();
    this.addGroupID = doc.id;

    // firestoreに追加
    await doc.set(
      {
        'groupName': addGroupName,
        'groupDescription': addGroupDescription,
        'groupID': addGroupID,
        'menberID': [currentUID],
      },
    );
    notifyListeners();
  }
}
