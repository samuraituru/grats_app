import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/group/folder/group_folder_model.dart';
import 'package:grats_app/presentation/group/item/group_item_page.dart';
import 'package:provider/provider.dart';

class GroupFolderPage extends StatelessWidget {
  Group group;

  GroupFolderPage({required this.group});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupFolderModel>(
      create: (_) => GroupFolderModel()..fetchFolder(group),
      child: Consumer<GroupFolderModel>(builder: (context, model, child) {
        final List<Folder>? folders = model.folders;

        if (folders == null) {
          return const SizedBox(
              width: 100,
              height: 100,
              child: Center(child: CircularProgressIndicator()));
        }
        final List<Widget> widgets = folders
            .map(
              (folder) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.yellow[100],
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GroupItemPage(folder: folder)),
                      );
                    },
                    onLongPress: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: const Text('フォルダを削除しますか？'),
                          actions: <Widget>[
                            SimpleDialogOption(
                              child: const Text('Yes'),
                              onPressed: () {
                                model.foldersDocDelete(folder);
                                Navigator.pop(context);
                              },
                            ),
                            SimpleDialogOption(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                      model.fetchFolder(group);
                    },
                    leading: const CircleAvatar(
                      backgroundColor: ThemeColors.whiteColor,
                      child: Icon(Icons.folder_open),
                    ),
                    title: Text('${folder.folderName}',
                        style: const TextStyle(fontSize: 20)),
                    subtitle: Text('${folder.folderDescription}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
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
                                      prefixIcon: const Icon(Icons.folder_open),
                                      labelText: 'Folder名を記載',
                                      //fillColor: ThemeColors.backGroundColor,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            //color: ThemeColors.whiteColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.all(10.0)),
                                  TextField(
                                    controller: model.folderDescController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.folder_open),
                                      labelText: '説明を記載',
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 40,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
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
                                  child: const Text('OK'),
                                  onPressed: () async {
                                    await model.updateFolder(folder);
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
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: ThemeColors.whiteColor),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: const Text('Folder'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add, color: ThemeColors.whiteColor),
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
                                  prefixIcon: const Icon(Icons.folder_open),
                                  labelText: 'Folder名を記載',
                                  //fillColor: ThemeColors.backGroundColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        //color: ThemeColors.whiteColor,
                                        ),
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(10.0)),
                              TextField(
                                controller: model.folderDescController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.folder_open),
                                  labelText: '説明を記載',
                                  //fillColor: ThemeColors.backGroundColor,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 40,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
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
                              child: const Text('OK'),
                              onPressed: () async {
                                try {
                                  await model.addFolder(group);
                                } catch (e) {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(e.toString()),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } finally {
                                  await model.fetchFolder(group);
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
