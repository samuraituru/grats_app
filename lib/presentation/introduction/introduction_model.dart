import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionModel extends ChangeNotifier {
  bool firstIntro = true;
  final controller =
  ConfettiController(duration: const Duration(seconds: 5));

  getPrefIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「intro」がキー名。見つからなければtrueを返す
    firstIntro = prefs.getBool('firstIntro') ?? true;
    notifyListeners();
  }

  setFirstIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("firstIntro", false);
    notifyListeners();
  }
}