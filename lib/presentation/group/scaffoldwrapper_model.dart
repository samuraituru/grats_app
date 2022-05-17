import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScaffoldWrapperModel extends ChangeNotifier{

  String? tags;
  String? tags2;
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addTag() async {
    if (tags == null || tags == "") {
      throw 'グループ名が入力されていません';
    }

    if (tags2 == null || tags2!.isEmpty) {
      throw '説明が入力されていません';
    }

    final doc = FirebaseFirestore.instance.collection('Tags').doc();


    // firestoreに追加
    await doc.set({
      'title': tags,
      'author': tags2,
    });
  }
}

