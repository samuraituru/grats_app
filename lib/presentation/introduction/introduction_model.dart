import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionModel extends ChangeNotifier {
  bool firstIntro = true;//Introductionを初めて見る場合はTrue、既に見ている場合はFalse
  final controller =
  ConfettiController(duration: const Duration(seconds: 5));

  void initAction() async {
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  void getPrefIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「firstIntro」がキー名。
    //初めて見る場合は未格納のためNullになり得る
    // NullであればTrueを返す
    firstIntro = prefs.getBool('firstIntro') ?? true;
    notifyListeners();
  }

 void setFirstIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //既に見たことを示すFalseを格納する
    await prefs.setBool("firstIntro", false);
    notifyListeners();
  }
}