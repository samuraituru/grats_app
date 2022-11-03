import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/record/item/recoed_item_model.dart';
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
              (item) => SizedBox(
                height: 150,
                child: Card(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('名前'),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                        Container(
                          width: 200,
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              '${item.itemName ?? '名前無し'}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('備考'),
                        Padding(
                          padding: EdgeInsets.all(6.0),
                        ),
                        Container(
                          width: 200,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              '${item.itemDescription ?? ''}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
