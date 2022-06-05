import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/domain/joingrouplist.dart';
import 'package:grats_app/presentation/group/folder/group_folder_model.dart';
import 'package:grats_app/presentation/group/item/group_item_page.dart';
import 'package:grats_app/presentation/group/scaffoldwrapper_page.dart';
import 'package:provider/provider.dart';

class GroupFloderPage extends StatelessWidget {
  JoinGroup joinGroup;
  GroupFloderPage({required this.joinGroup});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupFolderModel>(
      create: (_) => GroupFolderModel(null)..getFolder(joinGroup),
      child: Consumer<GroupFolderModel>(builder: (context, model, child) {
        final List<Folder>? folders = model.folders;
        model.joinGroup = joinGroup;

        if (folders == null) {
          return CircularProgressIndicator();
        }
        final List<Widget> widgets = folders
            .map(
              (folder) => ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GroupItemPage()),
                  );
                },
                leading: Text(''),
                title: Text(''),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){},
                ),
              ),
            )
            .toList();

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              centerTitle: true,
              title: Text('${joinGroup.groupName}'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Floderを追加'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  hintText: " Floder名を記載",
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                ),
                                onChanged: (text) {
                                  model.addFloderName = text;
                                },
                              ),
                              Padding(padding: EdgeInsets.all(10.0)),
                              TextField(
                                onChanged: (text) {
                                  model.addFloderDescription = text;
                                },
                                decoration: InputDecoration(
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
                                model.addFolder();
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
