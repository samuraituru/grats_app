import 'package:flutter/material.dart';
import 'package:grats_app/presentation/record/record_model.dart';
import 'package:provider/provider.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: ChangeNotifierProvider<RecordModel>(
        create: (_) => RecordModel(),
        child: Consumer<RecordModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(''),
            ),
          );
        }),
      ),
    );
  }
}