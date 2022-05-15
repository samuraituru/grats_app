import 'package:flutter/material.dart';
import 'package:grats_app/presentation/testpage/test_model1.dart';
import 'package:provider/provider.dart';

class TestPage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: ChangeNotifierProvider<TestModel1>(
        create: (_) => TestModel1(),
        child: Consumer<TestModel1>(builder: (context, model, child) {
          return Scaffold(
          );
        }),
      ),
    );
  }
}