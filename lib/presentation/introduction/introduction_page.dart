import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/presentation/home/home_page.dart';
import 'package:grats_app/presentation/introduction/Introduction_model.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IntroductionModel>(
      create: (_) => IntroductionModel(),
      child: Scaffold(
        body: Consumer<IntroductionModel>(builder: (context, model, child) {
          final controller = ConfettiController(duration: const Duration(seconds: 5));
          void confettiEvent() {
            controller.play();
          }
          final listPagesViewModel = [
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
                    color: Colors.redAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                bodyTextStyle:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
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
                    color: Colors.redAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                bodyTextStyle:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
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
                    color: Colors.redAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                bodyTextStyle:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
            ),
            PageViewModel(
              title: "始めてみよう",
              //body: '',
              bodyWidget: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ConfettiWidget(
                      confettiController: controller,
                      blastDirection: pi / 2,
                      // 紙吹雪を出す方向(この場合画面上に向けて発射)
                      emissionFrequency: 0.1,
                      // 発射頻度(数が小さいほど紙と紙の間隔が狭くなる)
                      minBlastForce: 5,
                      // 紙吹雪の出る瞬間の5フレーム分の速度の最小
                      maxBlastForce: 20,
                      // 紙吹雪の出る瞬間の5フレーム分の速度の最大(数が大きほど紙吹雪は遠くに飛んでいきます。)
                      numberOfParticles: 10,
                      // 1秒あたりの紙の枚数
                      gravity: 0.1,
                      // 紙の落ちる速さ(0~1で0だとちょーゆっくり)
                      colors: const <Color>[
                        // 紙吹雪の色指定
                        Colors.red,
                        Colors.blue,
                      ],
                    ),
                  ),
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
                        confettiEvent();
                      },
                      child: const Text(
                        "ログイン",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
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
                    color: Colors.redAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                bodyTextStyle:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
            ),
          ];
          return IntroductionScreen(
            pages: listPagesViewModel,
            onDone: () {
              model.setFirstIntro();
            },
            showSkipButton: true,
            back: const Icon(Icons.arrow_back),
            skip: const Text('skip'),
            next: const Text('next'),
            done: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: const Text("ゲストで始める",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
            ),
            dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(15.0, 10.0),
                color: Colors.black26,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0))),
          );
        }),
      ),
    );
  }
}
