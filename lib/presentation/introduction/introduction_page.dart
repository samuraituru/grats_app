import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/introduction/Introduction_model.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IntroductionModel>(
      create: (_) => IntroductionModel(),
      child: Scaffold(
        body: Consumer<IntroductionModel>(builder: (context, model, child) {
          final listPagesViewModel = [
            PageViewModel(
              titleWidget: SizedBox(
                width: 600,
                height: 600,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('見たい動画から気になる項目を\nカウントしてみよう',
                        style: TextStyle(
                            color: ThemeColors.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                    ),
                    Lottie.asset(
                      'lib/assets/images/movie_image.json',
                      width: 250,
                      height: 250,
                      fit: BoxFit.fill,
                    ),
                  ],
                )),
              ),
              reverse: true,
              body: "",
            ),
            PageViewModel(
              titleWidget: SizedBox(
                width: 600,
                height: 600,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('分析の結果をレコードに残そう',
                        style: TextStyle(
                            color: ThemeColors.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                    ),
                    Lottie.asset(
                      'lib/assets/images/record_image.json',
                      width: 250,
                      height: 250,
                      fit: BoxFit.fill,
                    ),
                  ],
                )),
              ),
              reverse: true,
              body: "",
            ),
            PageViewModel(
              titleWidget: SizedBox(
                width: 600,
                height: 600,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('グループ機能を使って\n情報を共有しよう',
                        style: TextStyle(
                            color: ThemeColors.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                    ),
                    Lottie.asset(
                      'lib/assets/images/group_image.json',
                      width: 250,
                      height: 250,
                      fit: BoxFit.fill,
                    ),
                  ],
                )),
              ),
              reverse: true,
              body: "",
            ),
            PageViewModel(
              titleWidget: SizedBox(
                width: 500,
                height: 500,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: buildConfetti(model)),
                    Text('Gratsをはじめましょう♪♪♪',
                        style: TextStyle(
                            color: ThemeColors.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                    ),
                    Lottie.asset(
                      'lib/assets/images/startup_image.json',
                      width: 250,
                      height: 250,
                      fit: BoxFit.fill,
                    ),
                  ],
                )),
              ),
              reverse: true,
              bodyWidget: Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        model.controller.play();
                        Navigator.of(context).pushReplacementNamed("/signUp");
                        model.setFirstIntro();
                      },
                      child: const Text(
                        "はじめる",
                        style: TextStyle(
                          color: ThemeColors.color,
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ThemeColors.whiteColor, //ボタンの背景色
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
          return IntroductionScreen(
            globalBackgroundColor: ThemeColors.color,
            pages: listPagesViewModel,
            onDone: () {
              model.setFirstIntro();//Introductionが終わると既に見たことを示すFalseを格納する
            },
            showSkipButton: true,
            back: const Icon(Icons.arrow_back),
            skip: const Text(
              'skip',
              style: TextStyle(
                color: ThemeColors.whiteColor,
              ),
            ),
            next: const Text(
              'next',
              style: TextStyle(
                color: ThemeColors.whiteColor,
              ),
            ),
            done: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/home");
                model.setFirstIntro();
              },
              child: const Text(
                "ゲストで始める",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: ThemeColors.whiteColor),
              ),
            ),
            dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(15.0, 10.0),
                color: ThemeColors.whiteColor,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0))),
          );
        }),
      ),
    );
  }

  Widget buildConfetti(model) {
    return ConfettiWidget(
      confettiController: model.controller,
      //displayTarget: true,
      blastDirectionality: BlastDirectionality.explosive,
      //blastDirection: pi / 2,// 紙吹雪を出す方向(この場合画面上に向けて発射)
      emissionFrequency: 1,
      // 発射頻度(数が小さいほど紙と紙の間隔が狭くなる)
      numberOfParticles: 2,
      // 1秒あたりの紙の枚数
      shouldLoop: false,
      maxBlastForce: 8,
      // 紙吹雪の出る瞬間の5フレーム分の速度の最大(数が大きほど紙吹雪は遠くに飛んでいきます。)
      minBlastForce: 5,
      // 紙吹雪の出る瞬間の5フレーム分の速度の最小
      colors: [Colors.green, Colors.pink, Colors.orange],
      maximumSize: Size(20, 20),
      minimumSize: Size(10, 10),
      gravity: 0.4,
      // 紙の落ちる速さ(0~1で0だとちょーゆっくり)
      particleDrag: 0.001,
    );
  }
}
