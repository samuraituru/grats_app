import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/group/group_blockList_page.dart';
import 'package:grats_app/presentation/slide_right_route.dart';
import 'package:grats_app/presentation/group/folder/group_folder_page.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:provider/provider.dart';

import '../../domain/group.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupModel>(
      create: (_) => GroupModel()..fetchAllGroups(),
      child: Consumer<GroupModel>(
        builder: (context, model, child) {
          final List<Group> groups = model.groups;

          if (groups == null) {
            return const SizedBox(
                width: 100,
                height: 100,
                child: Center(child: CircularProgressIndicator()));
          }
          final List<Widget> widgets = groups.map((group) {
            return ListTile(
              onTap: () {
                final groups = model.group;
                showModalBottomSheet(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    enableDrag: true,
                    isDismissible: false,
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return GroupModal(group: group);
                    }).whenComplete(() => model.fetchAllGroups());
              },
              leading: group.imgURL != ''
                  ? CircleAvatar(
                radius: 30,
                child: ClipOval(
                  child: Image.network(
                    group.imgURL ?? '',
                  ),
                ),
              )
                  : CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
              ),
              title: Text('${group.groupName}'),
              subtitle: Text('${group.groupDescription}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
            );
          }).toList();
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppBar(
                centerTitle: true,
                leading: IconButton(icon: Icon(Icons.list_alt), onPressed: () {
                  Navigator.push(context, SlideRightRoute(page: GroupBloclListPage()));
                }),
                title: Text('Group'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Groupを追加'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: " group名を記載",
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                  ),
                                  onChanged: (text) {
                                    model.groupName = text;
                                  },
                                ),
                                Padding(padding: EdgeInsets.all(10.0)),
                                TextField(
                                  onChanged: (text) {
                                    model.groupDescription = text;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: " 説明を記載",
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 50,
                                    ),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      model.pickImage();
                                    },
                                    child: const Text('画像を追加'))
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
                                child: const Text('OK'),
                                onPressed: () async {
                                  await model.addGroup();
                                  await model.fetchAllGroups();
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
        },
      ),
    );
  }

  void navigateTo(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }
}

class GroupModal extends StatelessWidget {
  Group group;

  GroupModal({required this.group, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupModel>(
      create: (_) => GroupModel(),
      child: Consumer<GroupModel>(builder: (context, model, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      iconSize: 30,
                      onPressed: () {
                        showModalBottomSheet(
                            enableDrag: true,
                            isDismissible: false,
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return GroupSettingModal(group: group);
                            });
                      },
                      icon: Icon(Icons.settings)),
                  model.isEnabled == false
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: Colors.grey,
                          ),
                          onPressed: () {
                            model.blockButtonEnable();
                            MySnackBar.show(
                                context: context, message: 'blockしました');
                          },
                          child: Icon(
                            Icons.block,
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            model.blockButtonDisable();
                            MySnackBar.show(
                                context: context, message: 'block解除しました');
                          },
                          child: Icon(Icons.block, color: Colors.red),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(100.0),
            ),
            GestureDetector(
              onTap: () async {
                await model.pickImage();
                await model.imageUpData(group);
                await model.fetchAllGroups();
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                height: 100,
                width: 100,
                child: (() {
                  if (group.imgURL == '') {
                    return const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                    );
                  } else if (model.imageFile != null) {
                    return Image.file(model.imageFile!);
                  }
                  return CircleAvatar(
                    radius: 30,
                    child: ClipOval(
                      child: Image.network(
                        group.imgURL!,
                      ),
                    ),
                  );
                })(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('${group.groupName}',
                  style: TextStyle(
                    fontSize: 24,
                  )),
            ),
            Card(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                      icon: const Icon(Icons.group, size: 30),
                      label:
                          const Text('Member', style: TextStyle(fontSize: 18)),
                    ),
                    SizedBox(
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey,
                        child:
                            Text('10', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GroupFloderPage(group: group)));
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  icon: const Icon(Icons.folder_open, size: 30),
                  label: const Text('Folder', style: TextStyle(fontSize: 18)),
                ),
                TextButton.icon(
                  onPressed: () {
                    model.shareGroupID(group);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  icon: const Icon(Icons.folder_open, size: 30),
                  label: const Text('招待', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

Color TextColor() {
  Color grey = Colors.grey;
  return grey;
}

class MySnackBar extends StatelessWidget {
  final String message;

  MySnackBar({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // 成功の場合に表示するSnackBar
  static show({
    required BuildContext context,
    required String message,
    Color mainColor = Colors.white,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //backgroundColor: Colors.black,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.check,
            color: mainColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(message, style: TextStyle(color: mainColor)),
        ],
      ),
      duration: const Duration(milliseconds: 3000),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ));
  }

  // 失敗の場合に表示するSnackBar
  static showError({
    required BuildContext context,
    required String message,
    Color mainColor = Colors.white,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(message),
        ],
      ),
      duration: const Duration(milliseconds: 3000),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ));
  }
}

class GroupSettingModal extends StatelessWidget {
  Group group;

  GroupSettingModal({required this.group, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupModel>(
      create: (_) => GroupModel(),
      child: Consumer<GroupModel>(builder: (context, model, child) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.all(100.0),
          ),
          Text('グループ名'),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              onChanged: (text) {},
              decoration: InputDecoration(
                hintText:
                    group.groupName != null ? '${group.groupName}' : 'Unknown',
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('グループ名を更新',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          ),
          ListTile(
            title: Text('通報', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {},
          ),
          ListTile(
            title: Text('グループを退会する',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            onTap: () {},
          ),
        ]);
      }),
    );
  }
}

