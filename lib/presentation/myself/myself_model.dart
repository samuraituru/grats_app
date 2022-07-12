import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/myuser.dart';
import 'package:grats_app/domain/objectboxFolder.dart';
import 'package:grats_app/domain/objectboxitem.dart';
import 'package:grats_app/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/myuser.dart';

class MyselfModel extends ChangeNotifier {
  final userNameController = TextEditingController();
  final userTargetController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final imagePicker = ImagePicker();
  String imgURL = '';
  File? imageFile;

  String? uID;
  MyUser myUser = MyUser();
  DocumentSnapshot? userDocSnapshot;
  bool isLoading = false;
  bool isLogin = false;

  void controllerClear() {
    emailController.clear();
    passwordController.clear();
  }

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
    this.folderLength = folderBox.getAll().length.toString();
    this.itemLength = itemBox.getAll().length.toString();
  }

  String? folderLength;
  String? itemLength;
  String userName = '';

  bool userNameValidate() {
    //userNameがNullまたは""である場合にtrueを返す
    if (userNameController.text == null || userNameController.text == "") {
      return true;
    }
    //入力値がある場合は、falseを返す
    return false;
  }

  bool userTargetValidate() {
    //userTargetがNullまたは""である場合にtrueを返す
    if (userTargetController.text == null || userTargetController.text == "") {
      return true;
    }
    //入力値がある場合は、falseを返す
    return false;
  }

  bool imageFileValidate() {
    //imageFileがNullである場合にtrueを返す
    if (imageFile == null) {
      return true;
    }
    //入力値がある場合は、falseを返す
    return false;
  }

  Future<void> userInfoUpdate() async {
    //下記の３つの関数がtrueつまり入力値がない場合は更新しない
    if (userNameValidate() && userTargetValidate() && imageFileValidate()) {
      throw '更新する内容がありません';
    }
    //更新する内容が1つでもあれば下記を実行
    // FireStorageへimgURLをアップロード
    String? imgURL;
    if (imageFile != null) {
      final task =
          await FirebaseStorage.instance.ref('Users/$uID').putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    // Firestoreに追加
    await FirebaseFirestore.instance.collection('Users').doc(uID).update({
      'userName': checkUserName(myUser),
      'userTarget': checkUserTarget(myUser),
      'imgURL': imgURL,
    });
    userNameController.clear();
    userTargetController.clear();
    notifyListeners();
  }

  String checkUserName(MyUser myUser) {
    if (userNameController.text == "") {
      return myUser.userName!;
    }
    return userNameController.text;
  }

  String checkUserTarget(MyUser myUser) {
    if (userTargetController.text == "") {
      return myUser.userTarget!;
    }
    return userTargetController.text;
  }

  Future<void> signOut() async {
    if (uID != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  Future<void> deleteUser() async {
    if (emailController.text == null) {
      throw 'Emailが入力されていません';
    }
    if (passwordController.text == null || passwordController.text.isEmpty) {
      throw 'Passwordが入力されていません';
    }
    if (uID != null) {
      //await FirebaseAuth.instance.signOut();
      AuthCredential credential = await EmailAuthProvider.credential(
          email: emailController.text, password: passwordController.text);

      await FirebaseAuth.instance.currentUser
          ?.reauthenticateWithCredential(credential);

      await FirebaseAuth.instance.currentUser?.delete();
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

  void deleteImageFile() {
    imageFile = null;
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

  Future<void> launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $url';
    }
  }

  final folderBox = store.box<objectboxFolder>();
  final itemBox = store.box<objectboxItem>();
}
