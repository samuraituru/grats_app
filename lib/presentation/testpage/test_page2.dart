import 'package:flutter/material.dart';
import 'package:grats_app/presentation/myself/myself_page.dart';
import 'package:grats_app/presentation/testpage/test_model2.dart';
import 'package:provider/provider.dart';

class TestPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<TestModel2>(
        create: (_) => TestModel2(),
        child: Consumer<TestModel2>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyselfPage()),
                  );
                },
              ),
              title: Text('Browser'),
            ),
            body: Column(
              children: [
                Text('${model.testInt}'),
                Stack(
                  children: model.WidgetList,
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () async {
                await showModalBottomSheet(
                  enableDrag: true,
                  isDismissible: false,
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Row(
                        children: [
                          Container(
                            width: 40,
                            child: FloatingActionButton(
                              heroTag: 'plus',
                              backgroundColor: Colors.pink,
                              tooltip: 'Action!',
                              child: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  model.incriment();
                                });
                              },
                            ),
                          ),
                          Text('${model.testInt}'),
                        ],
                      );
                    });
                  },
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
