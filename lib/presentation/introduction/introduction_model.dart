import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionModel extends ChangeNotifier {
  bool firstIntro = true;//Introductionを初めて見る場合はTrue、既に見ている場合はFalse
  final controller =
  ConfettiController(duration: const Duration(seconds: 5));

  getPrefIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「firstIntro」がキー名。
    //初めて見る場合は未格納のためNullになり得る
    // NullであればTrueを返す
    firstIntro = prefs.getBool('firstIntro') ?? true;
    notifyListeners();
  }

  setFirstIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //既に見たことを示すFalseを格納する
    await prefs.setBool("firstIntro", false);
    notifyListeners();
  }
}