import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionModel extends ChangeNotifier {
  bool firstIntro = false;

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
  var listPagesViewModel = [
    PageViewModel(
      title: "グループ機能",
      body: "自由にグループを作成しグループ内で情報を共有しよう!グループ毎に戦術や情報を追記する事ができるよ!",
      image: const Center(
        child: Icon(
          Icons.groups,
          size: 200,
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            color: Colors.redAccent, fontSize: 30, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
      ),
    ),
    PageViewModel(
      title: "レコード機能",
      body:
      "自分で分析した情報をレコードとして残す事ができるよ!レコードにまとめる事で後で振り返り易くなる所属しているグループに作成したレコードを追加できるよ!",
      image: const Center(
        child: Icon(
          Icons.create_outlined,
          size: 200,
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            color: Colors.redAccent, fontSize: 30, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
      ),
    ),
    PageViewModel(
      title: "分析サポート機能",
      body: "このアプリでは動画による分析をサポートするよ!分析の情報はレコードに出力ができるよ",
      image: const Center(
        child: Icon(
          Icons.camera_alt_outlined,
          size: 200,
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            color: Colors.redAccent, fontSize: 30, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
      ),
    ),
    PageViewModel(
      title: "始めてみよう",
      //body: '',
      bodyWidget: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // On button presed
            },
            child: const Text("新規登録"),
          ),
          SizedBox(
            width: 100,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // On button presed
              },
              child: const Text("ログイン",
                style: TextStyle(color: Colors.black,
                  fontSize: 15,),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent, //ボタンの背景色
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
      image: const Center(
        child: Icon(
          Icons.camera_alt_outlined,
          size: 200,
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            color: Colors.redAccent, fontSize: 30, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
      ),
    ),
  ];
}