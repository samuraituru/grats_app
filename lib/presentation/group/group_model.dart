import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/groups.dart';
import 'package:grats_app/domain/myuser.dart';
import 'package:grats_app/domain/record.dart';

class GroupModel extends ChangeNotifier {
  var controller = TextEditingController();
  var editText = '';
  var fruits = <String>['例)反則数'];
  var foloders = <Folder>[];
  var records = <Record>[];
  var groups = <Group>[];
  String addgName = '';
  MyUser myuser = MyUser();
 var gIDList;

  //final groups = <Group>[];
  String? uID;
  String? currentUID;
  String? gID;
  String? addgroup;
  QuerySnapshot? snapshot;
  DocumentSnapshot? docsnapshot;
  var menberIDMap = <String, String>{};
  var getgIDList;

  Future initAction() async {
    User? currentuser = await FirebaseAuth.instance.currentUser;
    this.currentUID = currentuser?.uid.toString();
    //ログイン中かつグループMAPを持っている場合、UsersのDocを取得
    if (currentUID != null) {
      print('currentUIDは${currentUID}');
      final DocumentSnapshot userDocSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUID)
          .get();

      final Map<String, dynamic>? data =
          userDocSnapshot.data() as Map<String, dynamic>?;
      this.gIDList = data!['gIDList'];
      print('gIDListは${this.gIDList}');

      getgIDList = await gIDList?.map((gID) async {
        print(gID);
        var doc = await FirebaseFirestore.instance.collection('Groups').doc('$gID').get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        final String menberID = data['uID'];
        print(menberID);
      }).toList();
      notifyListeners();
    }
  }
  Future initlist()async{
    getgIDList =  myuser.gIDList?.map((e) async {
      print(e);
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Groups').doc(e).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final String menberID = data['uID'];
      print(menberID);
      //return Group(menberID: menberID);
    }).toList();
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

  Future getGroupList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Groups').get();
    this.snapshot = snapshot;

    final List<Group> groups = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String gName = data['gName'];
      final String gDesc = data['gDesc'];
      final String gID = data['gID'];
      return Group(gName: gName, gDesc: gDesc, gID: gID);
    }).toList();
    this.groups = groups;
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
      return Group(gName: gName, gDesc: gDesc, gID: gID);
    }).toList();
    this.groups = groups;
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

  Future addGroup(Group group) async {
    if (group.gName == null || group.gName == "") {
      throw 'グループ名が入力されていません';
    }

    if (group.gDesc == null || group.gDesc!.isEmpty) {
      throw '説明が入力されていません';
    }

    final doc = FirebaseFirestore.instance.collection('Groups').doc(gID);

    // firestoreに追加
    await doc.set(
      {
        'name': group.gName,
        'description': group.gDesc,
        'gID': group.gID,
        'menberID': group.menberID,
      },
    );
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
