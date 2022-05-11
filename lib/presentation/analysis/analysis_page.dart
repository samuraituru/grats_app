import 'package:flutter/material.dart';
import 'package:grats_app/presentation/analysis/analysis_model.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:provider/provider.dart';

class AnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: ChangeNotifierProvider<AnalysisModel>(
        create: (_) => AnalysisModel(),
        child: Consumer<AnalysisModel>(builder: (context, model, child) {
          return Scaffold(
          );
        }),
      ),
    );
  }
}