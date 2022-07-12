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
                title: Text(item.itemName ?? '名前無し'),
                subtitle: Text(item.itemDescription ?? ''),
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
              title: Text('Item'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add,color: ThemeColors.whiteColor),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('アイテムを追加'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: model.itemNameController,
                                //textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.folder_open),
                                  labelText: 'アイテム名を記載',
                                  //fillColor: ThemeColors.backGroundColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      //color: ThemeColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10.0)),
                              TextField(
                                controller: model.itemDescriptionController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.folder_open),
                                  labelText: '説明を記載',
                                  //fillColor: ThemeColors.backGroundColor,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 40,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      //color: ThemeColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('キャンセル'),
                              onPressed: () {
                                Navigator.pop(context);
                                model.controllerClear();
                              },
                            ),
                            TextButton(
                              child: Text('OK'),
                              onPressed: () async {
                                try {
                                  model.putItem();
                                } catch (e) {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(e.toString()),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } finally {
                                  model.initAction(folderID);
                                  Navigator.pop(context);
                                  model.controllerClear();
                                }
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
          body: Container(
            color: ThemeColors.backGroundColor,
            child: Center(
              child: RefreshIndicator(
                onRefresh: () async {
                  model.initAction(folderID);
                },
                child: ListView(
                  children: itemsWidget,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
