import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/domain/joingrouplist.dart';
import 'package:grats_app/presentation/group/folder/group_folder_model.dart';
import 'package:grats_app/presentation/group/item/group_item_page.dart';
import 'package:grats_app/presentation/group/scaffoldwrapper_page.dart';
import 'package:provider/provider.dart';

class GroupFloderPage extends StatelessWidget {
  Group group;

  GroupFloderPage({required this.group});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupFolderModel>(
      create: (_) => GroupFolderModel(null)..getFolder(group),
      child: Consumer<GroupFolderModel>(builder: (context, model, child) {
        final List<Folder>? folders = model.folders;
        model.group = group;

        if (folders == null) {
          return const SizedBox(
              width: 100,
              height: 100,
              child: Center(child: CircularProgressIndicator()));
        }
        final List<Widget> widgets = folders
            .map(
              (folder) => ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupItemPage(folder: folder)),
                  );
                },
                title: Text('${folder.folderName}'),
                subtitle: Text('${folder.folderDescription}'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
            )
            .toList();

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              centerTitle: true,
              title: Text('${group.groupName}'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Folderを追加'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: " Folder名を記載",
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                ),
                                onChanged: (text) {
                                  model.folderName = text;
                                },
                              ),
                              Padding(padding: EdgeInsets.all(10.0)),
                              TextField(
                                onChanged: (text) {
                                  model.folderDescription = text;
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
                              child: const Text('キャンセル'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text('OK'),
                              onPressed: () async{
                               await model.addFolder();
                                await model.getFolder(group);
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
              elevation: 0.0,
            ),
          ),
          body: Center(
            child: ListView(
              children: widgets,
            ),
          ),
        );
      }),
    );
  }
}
