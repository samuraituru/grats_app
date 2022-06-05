import 'package:flutter/material.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/presentation/group/folder/group_folder_page.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:grats_app/presentation/myself/myself_page.dart';
import 'package:grats_app/presentation/testpage/test_model5.dart';
import 'package:provider/provider.dart';

class TestPage5 extends StatelessWidget {
  const TestPage5({
    Key? key,
    this.controller,
  }) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<TestModel5>(
        create: (_) => TestModel5(),
        child: Consumer<TestModel5>(
          builder: (context, model, child) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyselfPage()),
                    );
                  },
                ),
              ),
              body: Column(
                children: [
                  Center(child: TextButton(
                    onPressed: () => model.TestWhere(),
                    child: Text('Input'),
                  )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void navigateTo(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }
}
