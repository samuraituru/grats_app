import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/group/folder/group_folder_model.dart';
import 'package:grats_app/presentation/group/item/group_item_page.dart';
import 'package:provider/provider.dart';

class GroupFloderPage extends StatelessWidget {
  Group group;

  GroupFloderPage({required this.group});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupFolderModel>(
      create: (_) => GroupFolderModel()..fetchFolder(group),
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
              (folder) => Padding(
                padding: const EdgeInsets.only(right: 20,left: 20,bottom: 8,top: 8),
                child: Card(
                  elevation: 3,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroupItemPage(folder: folder)),
                      );
                    },
                    onLongPress: (){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Folder名を変更'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: model.folderNameController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.folder_open),
                                    labelText: 'Folder名を記載',
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
                                onPressed: () async{
                                  await model.folderUpdate(folder);
                                  await model.fetchFolder(group);
                                  Navigator.pop(context);
                                  model.controllerClear();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      model.foldersDocDelete(folder);
                    },
                    leading: CircleAvatar(
                      child: Icon(Icons.folder_open),
                    ),
                    title: Text('${folder.folderName}'),
                      tileColor:Colors.yellow[100],
                    subtitle: Text('${folder.folderDescription}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Folder名を変更'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: model.folderNameController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.folder_open),
                                      labelText: 'Folder名を記載',
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
                                    controller: model.folderDescController,
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
                                  onPressed: () async{
                                    await model.folderUpdate(folder);
                                    await model.fetchFolder(group);
                                    Navigator.pop(context);
                                    model.controllerClear();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            )
            .toList();

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,color: ThemeColors.whiteColor),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text('${group.groupName}'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add,color: ThemeColors.whiteColor),
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
                                controller: model.folderNameController,
                                //textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.folder_open),
                                  labelText: 'Folder名を記載',
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
                                controller: model.folderDescController,
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
                              onPressed: () async{
                               await model.addFolder();
                                await model.fetchFolder(group);
                                Navigator.pop(context);
                                model.controllerClear();
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
            child: RefreshIndicator(
              onRefresh: () async {
                await model.fetchFolder(group);
              },
              child: Container(
                color: ThemeColors.backGroundColor,
                child: ListView(
                  children: widgets,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
