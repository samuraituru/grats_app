import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/record/item/recoed_item_model.dart';
import 'package:grats_app/presentation/record/record_page.dart';
import 'package:grats_app/presentation/slide_right_route.dart';
import 'package:provider/provider.dart';

class RecordItemPage extends StatelessWidget {
  int folderID;

  RecordItemPage({required this.folderID});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecordItemModel>(
      create: (_) => RecordItemModel()..initAction(folderID),
      child: Consumer<RecordItemModel>(builder: (context, model, child) {
        List<Widget> itemsWidget = model.items
            ?.map(
              (item) => ListTile(
                leading: Text(item.itemName ?? '名前無し'),
                title: Text(item.itemDescription ?? ''),
              ),
            )
            .toList() as List<Widget>;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: ThemeColors.whiteColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              title: Text('Record'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Recordを追加'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: model.nameController,
                                decoration: const InputDecoration(
                                  hintText: " アイテム名を記載",
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
                                model.putItem();
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
              children: itemsWidget,
            ),
          ),
        );
      }),
    );
  }
}
