import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/group/folder/group_folder_page.dart';
import 'package:grats_app/presentation/group/group_blockList_page.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:grats_app/presentation/group/group_page_alerttabview.dart';
import 'package:grats_app/presentation/slide_right_route.dart';
import 'package:nil/nil.dart';
import 'package:provider/provider.dart';

import '../../domain/group.dart';

class GroupPage extends StatelessWidget {
  bool? isLogin;

  GroupPage({
    this.isLogin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupModel>(
      create: (_) => GroupModel()..fetchAllGroups(),
      child: Consumer<GroupModel>(
        builder: (context, model, child) {
          final List<Group> groups = model.groups;
          final currentUID = model.currentUID;
          if (model.isLoading) {
            return Container(
              width: 100,
              height: 100,
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (groups == null) {
            return const SizedBox(
                width: 100,
                height: 100,
                child: Center(child: CircularProgressIndicator()));
          }
          final List<Widget> widgets = groups.map((group) {
            return Visibility(
              visible: (group.isBlocks![currentUID] == false),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          enableDrag: true,
                          isDismissible: false,
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return GroupPageModal(
                                group: group, currentUID: currentUID!);
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
                        : const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey,
                          ),
                    title: Text('${group.groupName}'),
                    subtitle: Text('${group.groupDescription}'),
                    trailing: const Icon(Icons.keyboard_arrow_up),
                  ),
                ),
              ),
            );
          }).toList();
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: AppBar(
                centerTitle: true,
                leading: (isLogin!)
                    ? IconButton(
                        icon: const Icon(Icons.list_alt,
                            color: ThemeColors.whiteColor),
                        onPressed: () async {
                          await Navigator.push(context,
                              SlideRightRoute(page: GroupBloclListPage()));
                          model.fetchAllGroups();
                        })
                    : nil,
                title: const Text('Group'),
                actions: [
                  (isLogin!)
                      ? IconButton(
                          icon: const Icon(Icons.add,
                              color: ThemeColors.whiteColor),
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertTabView();
                                /*return AlertDialog(
                            //insetPadding: EdgeInsets.zero,
                            content: Container(
                              width: 550,
                              height: 400,
                              child: DefaultTabController(
                                length: _tabs.length,
                                child: Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: Colors.white,
                                    automaticallyImplyLeading: false,
                                    flexibleSpace: Column(
                                      children: [
                                        PreferredSize(
                                          child: TabBar(
                                            labelColor: Colors.black,
                                            isScrollable: true,
                                            tabs: _tabs.map((TabInfo tab) {
                                              return Tab(text: tab.label);
                                            }).toList(),
                                          ),
                                          preferredSize: Size.fromHeight(20.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  body: TabBarView(
                                      children: _tabs
                                          .map((tab) => tab.widget)
                                          .toList()),
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('キャンセル'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  model.controllerReset();
                                },
                              ),
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () async {
                                 await model.modalfinishActions();
                                 model.fetchAllGroups();
                                  Navigator.pop(context);
                                  model.controllerReset();
                                },
                              ),
                            ],
                          );*/
                              },
                            );
                            model.fetchAllGroups();
                          },
                        )
                      : const SizedBox()
                ],
                //elevation: 0.0,
              ),
            ),
            body: Container(
              color: ThemeColors.backGroundColor,
              child: Center(
                child: RefreshIndicator(
                    onRefresh: () async {
                      print('Loading New Data');
                      await model.fetchAllGroups();
                    },
                    child: (isLogin!)
                        ? ListView(
                            children: widgets,
                          )
                        : const Text(
                            'ゲストアカウントのため使用できません',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
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

class GroupPageModal extends StatelessWidget {
  Group group;
  String currentUID;

  GroupPageModal({required this.group, required this.currentUID, Key? key})
      : super(key: key);

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
                      icon: const Icon(Icons.settings)),
                  group.isBlocks![currentUID] == false
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.grey,
                          ),
                          onPressed: () {
                            model.blockButtonEnable(group, currentUID);
                            MySnackBar.show(
                                context: context, message: 'blockしました');
                          },
                          child: const Icon(
                            Icons.block,
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            model.blockButtonDisable(group, currentUID);
                            MySnackBar.show(
                                context: context, message: 'block解除しました');
                          },
                          child: const Icon(Icons.block, color: Colors.red),
                        ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(100.0),
            ),
            GestureDetector(
              onTap: () async {
                await model.imageUpData(group);
                await model.fetchAllGroups();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ThemeColors.backGroundColor, //枠線の色
                    width: 5, //枠線の太さ
                  ),
                  shape: BoxShape.circle,
                  //color: Colors.blue,
                ),
                height: 100,
                width: 100,
                child: (() {
                  if (model.imageFile != null) {
                    return ClipOval(
                      child: Image.file(model.imageFile!),
                    );
                  } else if (group.imgURL == '' || group.imgURL == null) {
                    return const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.add, size: 40, color: Colors.white),
                    );
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
              padding: const EdgeInsets.all(15.0),
              child: Text('${group.groupName}',
                  style: const TextStyle(
                    fontSize: 24,
                  )),
            ),
            const Card(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      icon: const Icon(Icons.group, size: 30),
                      label:
                          const Text('Member', style: TextStyle(fontSize: 18)),
                    ),
                    SizedBox(
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey,
                        child: Text('${group.memberIDs?.length}',
                            style: const TextStyle(color: Colors.white)),
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
                                GroupFolderPage(group: group)));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  icon: const Icon(Icons.folder_open, size: 30),
                  label: const Text('Folder', style: TextStyle(fontSize: 18)),
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

  const MySnackBar({required this.message});

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
          const SizedBox(
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
          const Icon(
            Icons.error,
            color: Colors.white,
          ),
          const SizedBox(
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
          const Padding(
            padding: EdgeInsets.all(80.0),
          ),
          const Text('グループ名'),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: model.groupRenameController,
              decoration: InputDecoration(
                hintText:
                    group.groupName != null ? '${group.groupName}' : 'Unknown',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
          ),
          const Text('説明'),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: model.groupReDescController,
              decoration: InputDecoration(
                hintText: group.groupDescription != null
                    ? '${group.groupDescription}'
                    : 'Unknown',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
          ),
          TextButton(
            onPressed: () async {
              try {
                await model.groupNameUpdate(group);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } catch (e) {
                print(e.toString());
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(e.toString()),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: const Text('グループ情報を更新',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          ),
          const Padding(
            padding: EdgeInsets.all(25.0),
          ),
          ListTile(
            onTap: () {
              model.shareGroupID(group);
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Icon(Icons.share, size: 30),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Group-Codeを発行',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Icon(Icons.help, size: 30),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      Text('通報', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Icon(Icons.group_remove, size: 30),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('グループから退会する',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
                ),
              ],
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  //title: new Text('AlertDialog'),
                  content: const Text('グループから退会しますか？'),
                  actions: <Widget>[
                    SimpleDialogOption(
                      child: const Text('Yes'),
                      onPressed: () async {
                        await model.groupWithdraw(group);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
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
          ),
          ListTile(
            title: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Icon(Icons.delete_forever, size: 30),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('グループを削除する',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
                ),
              ],
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  //title: new Text('AlertDialog'),
                  content: const Text('グループを削除しますか？'),
                  actions: <Widget>[
                    SimpleDialogOption(
                      child: const Text('Yes'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            //title: new Text('AlertDialog'),
                            content: const Text('一度削除したグループは元に戻せませんがよろしいですか？'),
                            actions: <Widget>[
                              SimpleDialogOption(
                                child: const Text('Yes'),
                                onPressed: () async {
                                  await model.deleteGroup(group);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              ),
                              SimpleDialogOption(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
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
          ),
        ]);
      }),
    );
  }
}

class TabInfo {
  String label;
  Widget widget;

  TabInfo(this.label, this.widget);
}
