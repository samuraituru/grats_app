import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/record/item/record_item_page.dart';
import 'package:grats_app/presentation/record/record_model.dart';
import 'package:grats_app/presentation/slide_left_route.dart';
import 'package:provider/provider.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecordModel>(
      create: (_) => RecordModel(),
      child: Consumer<RecordModel>(builder: (context, model, child) {
        List<Widget> folders = model.folderBox
            .getAll()
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
                          SlideLeftRoute(
                              exitPage: this,
                              enterPage: RecordItemPage(folderID: folder.id)));
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
                                model.foldersBoxRemove(folder);
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
                    },
                    leading: const CircleAvatar(
                      backgroundColor: ThemeColors.whiteColor,
                      child: Icon(Icons.folder_open),
                    ),
                    title: Text(folder.floderName ?? '名前無し',
                        style: const TextStyle(fontSize: 20)),
                    subtitle: Text('${folder.floderDescription}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: AlertDialog(
                                title: const Text('Folder名を変更'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: model.folderNameController,
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.folder_open),
                                        labelText: 'Folder名を記載',
                                        //fillColor: ThemeColors.backGroundColor,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              //color: ThemeColors.whiteColor,
                                              ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.all(10.0)),
                                    TextField(
                                      controller: model.folderDescController,
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.folder_open),
                                        labelText: '説明を記載',
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 40,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    onPressed: () {
                                      model.updateFolderName(folder);
                                      Navigator.pop(context);
                                      model.controllerClear();
                                    },
                                  ),
                                ],
                              ),
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
              title: const Text('Record'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add, color: ThemeColors.whiteColor),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Recordを追加'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: model.folderNameController,
                                //textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.folder_open),
                                  labelText: 'フォルダ名を記載',
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
                                  model.putFolder();
                                } catch (e) {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(e.toString()),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } finally {
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
            ),
          ),
          body: Container(
            color: ThemeColors.backGroundColor,
            child: Center(
              child: RefreshIndicator(
                onRefresh: () async {
                  model.fetchBox(context);
                },
                child: ListView(
                  children: folders,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
