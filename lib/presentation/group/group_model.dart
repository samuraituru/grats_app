import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/domain/myuser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class GroupModel extends ChangeNotifier {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupDescController = TextEditingController();
  TextEditingController groupCordController = TextEditingController();
  TextEditingController groupRenameController = TextEditingController();
  TextEditingController groupReDescController = TextEditingController();

  void controllerReset() {
    groupNameController.clear();
    groupDescController.clear();
    groupCordController.clear();
    notifyListeners();
  }

  final imagePicker = ImagePicker();
  File? imageFile;
  var editText = '';
  bool isEnabled = false;

  Map<String, dynamic> isBlocksTrue(String currentUID) {
    //ブロックするため、Trueをセットする
    isBlocks[currentUID] = true;
    return isBlocks;
  }

  Map<String, dynamic> isBlocksFalse(String currentUID) {
    //ブロックするため、Trueをセットする
    isBlocks[currentUID] = false;
    return isBlocks;
  }

  Future<void> blockButtonEnable(Group group, String currentUID) async {
    if (currentUID.isEmpty || currentUID == "") {
      throw 'loginされていません';
    }
    group.isBlocks![currentUID] = true;

    final groupsDoc =
        FirebaseFirestore.instance.collection('Groups').doc(group.groupID);
    await groupsDoc.update(
      {
        'isBlocks': isBlocksTrue(currentUID),
      },
    );
    notifyListeners();
  }

  Future<void> blockButtonDisable(Group group, String currentUID) async {
    if (currentUID.isEmpty || currentUID == "") {
      throw 'loginされていません';
    }
    group.isBlocks![currentUID] = false;

    final groupsDoc =
        FirebaseFirestore.instance.collection('Groups').doc(group.groupID);
    await groupsDoc.update(
      {
        'isBlocks': isBlocksFalse(currentUID),
      },
    );
    notifyListeners();
  }

  Group? group;
  List<Group> groups = [];
  List<Group> blockGroups = [];

  //String groupName = '';
  String groupDescription = '';
  MyUser myuser = MyUser();

  List<String> gIDList = [];

  Map<String, dynamic> memberIDsMap = {};
  List<dynamic> memberIDs = [];
  Map<String, dynamic> isBlocks = {};

  String groupID = '';

  String? uID;
  String? currentUID;
  String? groupName;
  String? groupDesc;

  QuerySnapshot? snapshot;
  DocumentSnapshot? docsnapshot;
  DocumentSnapshot? groupsSnapshot;

  Future<void> fetchAllGroups() async {
    User? currentuser = FirebaseAuth.instance.currentUser;
    currentUID = currentuser?.uid.toString();
    if (currentUID == null || currentUID == "") {
      throw 'loginされていません';
    }
    final QuerySnapshot joinGroupsDoc = await FirebaseFirestore.instance
        .collection('Groups')
        .where("memberIDs", arrayContains: currentUID)
        .get();
    print(joinGroupsDoc);
    if (joinGroupsDoc.docs.isNotEmpty) {
      final List<Group> joins =
          joinGroupsDoc.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final groupID = data['groupID'] as String?;
        final groupName = data['groupName'] as String?;
        final groupDescription = data['groupDescription'] as String?;
        final memberIDs = data['memberIDs'] as List<dynamic>?;
        final isBlocks = data['isBlocks'] as Map<String, dynamic>?;
        final imgURL = data['imgURL'] as String?;

        return Group(
          groupID: groupID,
          groupName: groupName,
          groupDescription: groupDescription,
          memberIDs: memberIDs,
          isBlocks: isBlocks,
          imgURL: imgURL ?? '',
        );
      }).toList();
      groups = joins;
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

  Future<NetworkImage> getImage(group) async {
    NetworkImage networkImage = NetworkImage(group);
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

  void setName(String name) {
    groupName = name;
    notifyListeners();
  }

  Future<void> addGroup() async {
    User? currentuser = FirebaseAuth.instance.currentUser;
    currentUID = currentuser?.uid.toString();
    print(currentUID);

    //GroupのDocumentReferenceを取得
    //DocのIDは自動採番される
    final groupsDoc = FirebaseFirestore.instance.collection('Groups').doc();
    print('グループドキュメントは$groupsDoc');

    // FireStorageへアップロード
    String? imgURL;
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('Groups/${groupsDoc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    //GroupのIDを取得
    groupID = groupsDoc.id;

    //FirestoreにGroups情報を追加
    await groupsDoc.set(
      {
        'groupName': groupNameController.text,
        'groupDescription': groupDescController.text,
        'groupID': groupID,
        'memberIDs': listAdd(currentUID!), //memberIDsに自身のUIDを追加
        'isBlocks': isBlocksAdd(currentUID!),
        'imgURL': imgURL ?? '',
      },
    );
    notifyListeners();
  }

  Map<String, dynamic> isBlocksAdd(String currentUID) {
    //初期値はブロックしていないため、Falseをセットする
    isBlocks[currentUID] = false;
    return isBlocks;
  }

  List<dynamic> listAdd(String currentUID) {
    memberIDs.add(currentUID);
    return memberIDs;
  }

  Map<String, dynamic> mapAdd(String currentUID) {
    memberIDsMap['UID'] = currentUID;
    return memberIDsMap;
  }

  Future<void> pickImage() async {
    //GalleryからImageを取得
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      //格納されたImageのPathを取得
      imageFile = File(pickedFile.path);
    }

    notifyListeners();
  }

  Future<void> imageUpData(Group group) async {
    //GalleryからImageを取得
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      //格納されたImageのPathを取得
      imageFile = File(pickedFile.path);
    }

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
  }

  void shareGroupID(Group group) {
    Share.share(group.groupID!);
    notifyListeners();
  }

  Future<void> modalFinishActions() async {
    if (groupNameController.text.isNotEmpty && groupNameController.text != '') {
      await addGroup();
    } else if (groupCordController.text.isNotEmpty) {
      await groupCodeJoin();
    }
  }

  String? groupCord;

  Future<void> groupCodeJoin() async {
    if (groupCordController.text.isEmpty || groupCordController.text == "") {
      throw 'グループコードが入力されていません';
    }
    groupCord = groupCordController.text;

    //groupCordからGroupのDocumentReferenceを取得
    final groupCordDoc =
        FirebaseFirestore.instance.collection('Groups').doc(groupCord!);

    User? currentuser = FirebaseAuth.instance.currentUser;
    currentUID = currentuser?.uid.toString();

    if (currentUID != null) {
      await groupCordDoc.update(
        {
          'memberIDs': listAdd(currentUID!), //memberIDsに自身のUIDを追加
          'isBlocks': isBlocksAdd(currentUID!),
        },
      );
    }
    notifyListeners();
  }

  Future<void> fetchBlockList() async {
    User? currentuser = FirebaseAuth.instance.currentUser;
    currentUID = currentuser?.uid.toString();

    final QuerySnapshot blockGroupsDoc = await FirebaseFirestore.instance
        .collection('Groups')
        .where("isBlocks.$currentUID", isEqualTo: true)
        .get();

    if (blockGroupsDoc.docs.isNotEmpty) {
      final List<Group> joins =
          blockGroupsDoc.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final groupID = data['groupID'] as String?;
        final groupName = data['groupName'] as String?;
        final groupDescription = data['groupDescription'] as String?;
        final memberIDs = data['memberIDs'] as List<dynamic>?;
        final isBlocks = data['isBlocks'] as Map<String, dynamic>?;
        final imgURL = data['imgURL'] as String?;

        return Group(
          groupID: groupID,
          groupName: groupName,
          groupDescription: groupDescription,
          memberIDs: memberIDs,
          isBlocks: isBlocks,
          imgURL: imgURL ?? '',
        );
      }).toList();
      blockGroups = joins;
      notifyListeners();
    }
  }

  Future<void> groupNameUpdate(Group group) async {
    User? currentuser = FirebaseAuth.instance.currentUser;
    currentUID = currentuser?.uid.toString();

    if (groupRenameController.text.isEmpty ||
        groupRenameController.text == "") {
      throw 'グループ名が入力されていません';
    }
    if (groupReDescController.text.isEmpty ||
        groupReDescController.text == "") {
      throw '説明が入力されていません';
    }

    final groupsDoc =
        FirebaseFirestore.instance.collection('Groups').doc(group.groupID);
    await groupsDoc.update(
      {
        'groupName': groupRenameController.text,
        'groupDescription': groupReDescController.text,
      },
    );
    notifyListeners();
  }

  Future<void> groupWithdraw(Group group) async {
    User? currentuser = FirebaseAuth.instance.currentUser;
    currentUID = currentuser?.uid.toString();

    final groupsDoc =
        FirebaseFirestore.instance.collection('Groups').doc(group.groupID);
    await groupsDoc.update(
      {
        'memberIDs': removeMyID(group, currentUID!), //memberIDsに自身のUIDを追加
        'isBlocks': removeIsBlocks(currentUID!),
      },
    );
    notifyListeners();
  }

  List<dynamic>? removeMyID(Group group, String currentUID) {
    group.memberIDs?.remove(currentUID);
    return group.memberIDs;
  }

  Map<String, dynamic> removeIsBlocks(String currentUID) {
    //指定したキーを値ごと削除
    isBlocks.remove(currentUID);
    return isBlocks;
  }

  Future<void> deleteGroup(Group group) async {
    final groupsDoc =
        FirebaseFirestore.instance.collection('Groups').doc(group.groupID);
    await groupsDoc.delete();
  }
}
