import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/myuser.dart';
import 'package:grats_app/presentation/login/login_page.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/myuser.dart';

class MyselfModel extends ChangeNotifier {
  TextEditingController textController = TextEditingController();
  final imagePicker = ImagePicker();
  String imgURL = '';
  File? imageFile;

  String? uid;
  MyUser? myUser;
  DocumentSnapshot? userDocSnapshot;

  Future<void> fetchMyUser() async {
    //FirebaseAuthからcurrentUser-IDを取得
    User? currentUser = await FirebaseAuth.instance.currentUser;
    this.uid = currentUser?.uid.toString();

    if (currentUser != null) {
      final userDocSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      this.userDocSnapshot = userDocSnapshot;

      final data = userDocSnapshot.data();
      final userName = data!['userName'] as String?;
      final target = data['target'] as String?;
      final groupID = data['groupID'] as String?;
      final imgURL = data['imgURL'] as String?;
      MyUser myUser = MyUser(
          userName: userName,
          target: target,
          groupID: groupID,
          imgURL: imgURL ?? '');
      this.myUser = myUser;
      notifyListeners();
    }
  }

  void myselfInfoAdd(MyUser user) async {
    if (user.userName == null || user.userName == "") {
      throw 'プロフィール名が入力されていません';
    }

    if (user.target == null || user.target!.isEmpty) {
      throw '目標が入力されていません';
    }

    final usersDoc = FirebaseFirestore.instance.collection('Users').doc();

    // FireStorageへアップロード
    String? imgURL;
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('Users/${usersDoc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    // Firestoreに追加
    await usersDoc.set({
      'userName': user.userName,
      'target': user.target,
      'imgURL': imgURL ?? '',
    });
    notifyListeners();
  }

  void updateMyselfInfo(MyUser user) {
    if (user.userName == null || user.userName == "") {
      throw 'プロフィール名が入力されていません';
    }

    if (user.target == null || user.target!.isEmpty) {
      throw '目標が入力されていません';
    }
    FirebaseFirestore.instance.collection('Users').doc(uid).update({
      'userName': user.userName,
      'target': user.target,
    });
    notifyListeners();
  }

 Future<void> signOut(context) async {
    if (uid != null) {
      await FirebaseAuth.instance.signOut();
      //Navigator.of(context).pop();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
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
}
