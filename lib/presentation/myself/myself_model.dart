import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/myuser.dart';
import '../../domain/myuser.dart';

class MyselfModel extends ChangeNotifier {
  var textcontroller = TextEditingController();

  String? uid;
  MyUser myuser = MyUser();
  DocumentSnapshot? snapshot;

  Future getMyuser() async {
    User? currentuser = await FirebaseAuth.instance.currentUser;
    this.uid = currentuser?.uid.toString();

    final snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    this.snapshot = snapshot;

    final Map<String, dynamic>? data = snapshot.data();
    myuser.userName = data!['userName'];
    myuser.target = data['target'];
    myuser.gID = data['gID'];
    notifyListeners();
  }

  Future addMyselfInfo(MyUser user) async {
    if (user.userName == null || user.userName == "") {
      throw 'プロフィール名が入力されていません';
    }

    if (user.target == null || user.target!.isEmpty) {
      throw '目標が入力されていません';
    }

    final doc = FirebaseFirestore.instance.collection('Users').doc();

    // firestoreに追加
    await doc.set({
      'userName': user.userName,
      'target': user.target,
    });
  }

  updateMyselfInfo(MyUser user) {
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
  }
}
