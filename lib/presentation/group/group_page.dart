import 'package:flutter/material.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<GroupModel>(
        create: (_) => GroupModel(),
        child: Consumer<GroupModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Group'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('タイトル'),
                            content: TextField(
                              decoration: InputDecoration(hintText: "ここに入力"),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('キャンセル'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  //OKを押したあとの処理
                                },
                              ),
                            ],
                          );
                        });
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
