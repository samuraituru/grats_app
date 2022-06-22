import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/domain/myuser.dart';
import 'package:image_picker/image_picker.dart';

class GroupModel extends ChangeNotifier {
  var controller = TextEditingController();
  final imagePicker = ImagePicker();
  File? imageFile;
  var editText = '';

  Group? group;
  List<Group> groups = [];

  String groupName = '';
  String groupDescription = '';
  MyUser myuser = MyUser();

  List<String> gIDList = [];

  List<String> memberIDs = [];
  Map<String,dynamic> memberIDsMap = {};
  String groupID = '';

  String? uID;
  String? currentUID;
  String? addgroup;
  QuerySnapshot? snapshot;
  DocumentSnapshot? docsnapshot;
  DocumentSnapshot? groupsSnapshot;

  Future<void> fetchAllJoinGroups() async {
    User? currentuser = await FirebaseAuth.instance.currentUser;
    this.currentUID = currentuser?.uid.toString();
    if (currentUID == null || currentUID == "") {
      throw 'loginされていません';
    }
    final QuerySnapshot joinGroupsDoc = await FirebaseFirestore.instance
        .collection('Groups')
        .where("memberIDs.UID", isEqualTo: currentUID)
        .get();

    if (joinGroupsDoc != null) {
      final List<Group> joins =
          joinGroupsDoc.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String groupID = data['groupID'];
        final String groupName = data['groupName'];
        final String groupDescription = data['groupDescription'];
        final Map<String, dynamic> memberIDs = data['memberIDs'];
        final String imgURL = data['imgURL'];

        return Group(
          groupID: groupID,
          groupName: groupName,
          groupDescription: groupDescription,
          memberIDs: memberIDs,
          imgURL: imgURL,
        );
      }).toList();
      this.groups = joins;
      notifyListeners();
    }
  }

  Future<Group> fetchGroups(Group group) async {
    final DocumentSnapshot GroupsSnapshot = await FirebaseFirestore.instance
        .collection('Groups')
        .doc(group.groupID)
        .get();

    Map<String, dynamic> data = GroupsSnapshot.data() as Map<String, dynamic>;
    final String groupID = data['groupID'];
    final String groupName = data['groupName'];
    //final String folderID = data['folderID'];

    return group = Group(groupID: groupID, groupName: groupName);
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

  Future<NetworkImage> getImage(group) async {
    NetworkImage networkImage = await NetworkImage(group);
    return networkImage;
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

  Future<void> addGroup() async {
    if (groupName == null || groupName == "") {
      throw 'グループ名が入力されていません';
    }
    if (groupDescription == null || groupDescription.isEmpty) {
      throw '説明が入力されていません';
    }

    //GroupのDocumentReferenceを取得
    final groupsDoc = FirebaseFirestore.instance.collection('Groups').doc();

    // Fire-Storageへアップロード
    String? imgURL;
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('Groups/${groupsDoc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    //GroupのIDを取得
    this.groupID = groupsDoc.id;

    //FirestoreにGroups情報を追加
    await groupsDoc.set(
      {
        'groupName': groupName,
        'groupDescription': groupDescription,
        'groupID': groupID,
        'memberIDs': mapAdd(currentUID!), //memberIDsに自身のUIDを追加
        'imgURL': imgURL,
      },
    );
    notifyListeners();
  }

  List<String> memberListAdd(String currentUID) {
    memberIDs.add(currentUID);
    return memberIDs;
  }
  Map<String, dynamic> mapAdd(String currentUID){
    memberIDsMap['UID'] = currentUID;
    return memberIDsMap;
  }

  Future pickImage() async {
    //GalleryからImageを取得
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      //格納されたImageのPathを取得
      imageFile = File(pickedFile.path);
    }
  }

  Future<void> imageUpData(Group group) async {
    final groupsDoc =
        FirebaseFirestore.instance.collection('Groups').doc(group.groupID);
    String? imgURL;
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('Groups/${group.groupID}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
      print(imgURL);
    }

    //FirestoreのGroup情報を更新
    await groupsDoc.update(
      {
        //自身のグループのimgURLを更新
        'imgURL': imgURL ?? '',
      },
    );
    notifyListeners();
  }
}
