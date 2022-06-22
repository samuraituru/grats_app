import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/presentation/group/item/group_item_model.dart';
import 'package:provider/provider.dart';

class GroupItemPage extends StatelessWidget {
  Folder folder;

  GroupItemPage({required this.folder});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupItemModel>(
      create: (_) => GroupItemModel(null)..getItem(folder),
      child: Consumer<GroupItemModel>(
        builder: (context, model, child) {
          if (model.items == null) {
            return const SizedBox(width: 100,height: 100,child: Center(child: CircularProgressIndicator()));
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('${folder.folderName}'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('アイテムを追加'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: " アイテム名を記載",
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                ),
                                onChanged: (text) {
                                  model.itemName = text;
                                },
                              ),
                              Padding(padding: EdgeInsets.all(10.0)),
                              TextField(
                                onChanged: (text) {
                                  model.itemDescription = text;
                                },
                                decoration: const InputDecoration(
                                  hintText: " 説明を記載",
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 50,
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
                                model.setItem();
                                model.getItem(folder);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),
            body: CustomScrollView(
              slivers: [
                SliverStickyHeader.builder(
                  builder: (context, state) => Container(
                    height: 60.0,
                    color: (state.isPinned ? Colors.pink : Colors.lightBlue)
                        .withOpacity(1.0 - state.scrollPercentage),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Item',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(model.items![index].itemName),
                            Text('${model.items![index].itemDescription}'),
                          ],
                        ),
                      ),
                      childCount: model.items?.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
