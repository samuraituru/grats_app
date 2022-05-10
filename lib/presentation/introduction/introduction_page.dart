import 'package:flutter/material.dart';
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
          return IntroductionScreen(
            pages: model.listPagesViewModel,
            onDone: () {
              // When done button is press
            },
            onSkip: () {
              // You can also override onSkip callback
            },
            showSkipButton: true,
            back: const Icon(Icons.arrow_back),
            skip: const Text('skip'),
            next: const Text('次へ'),
            done: const Text("ゲストで始める",
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12)),
            dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
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