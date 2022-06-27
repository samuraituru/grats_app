import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/myuser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/myuser.dart';

class MyselfModel extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userTargetController = TextEditingController();

  final imagePicker = ImagePicker();
  String imgURL = '';
  File? imageFile;

  String? uID;
  MyUser myUser = MyUser();
  DocumentSnapshot? userDocSnapshot;
  bool isLoading = false;
  bool isLogin = false;

  void switchLogin() {
    isLogin = true;
    notifyListeners();
  }

  void switchLogout() {
    isLogin = false;
    notifyListeners();
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMyUser() async {
    startLoading();
    //FirebaseAuthからcurrentUser-IDを取得
    User? currentUser = await FirebaseAuth.instance.currentUser;
    this.uID = currentUser?.uid.toString();
    print('現在のUIDは${uID}');

    if (currentUser == null) {
      switchLogout();
      throw 'Loginしていません';
    }
    switchLogin();
    final userDocSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uID).get();
    this.userDocSnapshot = userDocSnapshot;

    final data = userDocSnapshot.data();
    final userName = data!['userName'] as String?;
    final target = data['userTarget'] as String?;
    final groupIDs = data['groupID'] as Map<String, dynamic>?;
    final imgURL = data['imgURL'] as String?;
    MyUser myUser = MyUser(
        userName: userName,
        userTarget: target,
        groupIDs: groupIDs,
        imgURL: imgURL ?? '');
    this.myUser = myUser;
    notifyListeners();
    print(myUser);
    endLoading();
  }

  Future<void> userInfoUpdate() async {
    if (userNameController.text == null || userNameController.text == "") {
      throw 'プロフィール名が入力されていません';
    }

    if (userTargetController.text == null ||
        userTargetController.text.isEmpty) {
      throw '目標が入力されていません';
    }

    // FireStorageへアップロード
    String? imgURL;
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('Users/${uID}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    // Firestoreに追加
    await FirebaseFirestore.instance.collection('Users').doc(uID).update({
      'userName': userNameController.text,
      'userTarget': userTargetController.text,
      'imgURL': imgURL,
    });
    userNameController.clear();
    userTargetController.clear();
    notifyListeners();
  }

  Future<void> updateMyselfInfo(MyUser user) async {
    if (user.userName == null || user.userName == "") {
      throw 'プロフィール名が入力されていません';
    }

    if (user.userTarget == null || user.userTarget!.isEmpty) {
      throw '目標が入力されていません';
    }
    await FirebaseFirestore.instance.collection('Users').doc(uID).update({
      'userName': user.userName,
      'userTarget': user.userTarget,
    });
    notifyListeners();
  }

  Future<void> signOut(context) async {
    if (uID != null) {
      await FirebaseAuth.instance.signOut();
    }
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

  String id = "";
  String groupID = 'test';

  void shareGroupURL() {
    String url =
        "https://grats.page.link/?link=https%3A%2F%2Fgrats.page.link%2Fpost?id=${id}&apn=com.example.grats_app";
    Share.share(url);
  }
  void sharegroupID() {
      Share.share(groupID);
  }

  Future<void> initDeepLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      final Uri? deepLink = dynamicLinkData.link;

      if (deepLink != null) {
        //ここにdeepLink変数を基に処理を書いていく
        OpenPost(deepLink.queryParameters["id"].toString()); //id(つまりABC123)を渡す
      }
    }).onError((error) async {
      print('onLinkError');
      print(error.message);
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      //ここにdeepLink変数を基に処理を書いていく
      OpenPost(deepLink.queryParameters["id"].toString()); //id(つまりABC123)を渡す
    }
  }

  void OpenPost(String path) {
    print(path);
  }
}
