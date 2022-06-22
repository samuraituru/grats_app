import 'package:flutter/material.dart';
import 'package:grats_app/presentation/record/record_model.dart';
import 'package:provider/provider.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<RecordModel>(
        create: (_) => RecordModel(),
        child: Consumer<RecordModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppBar(
                centerTitle: true,
                title: Text('Record'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Recordを追加'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: model.nameController,
                                  decoration: const InputDecoration(
                                    hintText: " フォルダー名を記載",
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                  ),
                                ),
                                TextField(
                                  controller: model.descriptionController,
                                  decoration: const InputDecoration(
                                    hintText: " 説明を記載",
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                  ),
                                ),
                              ],
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
                                  model.putFolder();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
                elevation: 0.0,
              ),
            ),
            body: Center(
              child: ListView(
                children:
                model.fetchBox(context),
              ),
            ),
          );
        }),
      ),
    );
  }
}
