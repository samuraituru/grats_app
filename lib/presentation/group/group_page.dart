import 'package:flutter/material.dart';
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
      create: (_) => GroupModel()..fetchAllJoinGroups(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<GroupModel>(
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
                      }).whenComplete(() => model.fetchAllJoinGroups());
                },
                leading: group.imgURL != ''
                    ? CircleAvatar(
                        radius: 30,
                        child: ClipOval(
                          child: Image.network(
                            group.imgURL,
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
                  title: Text('Groups'),
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
                                    await model.fetchAllJoinGroups();
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
        return SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(iconSize: 30,onPressed: () {}, icon: Icon(Icons.star)),
                    IconButton(iconSize: 30,onPressed: () {}, icon: Icon(Icons.block)),
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
                  await model.fetchAllJoinGroups();
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
                          group.imgURL,
                        ),
                      ),
                    );
                  })(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Flexible(
                  child: Text('${group.groupName}',
                      style: TextStyle(
                        fontSize: 24,
                      )),
                ),
              ),
              Card(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.accessibility)),
                  Column(
                    children: [
                      IconButton(
                          iconSize: 30,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GroupFloderPage(group: group)));
                          },
                          icon: Icon(Icons.folder_open)),
                      SizedBox(
                        child: TextButton.icon(
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
                          icon: const Icon(Icons.folder_open,size:30),
                          label: const Text('Folder',style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

Color TextColor() {
  Color grey = Colors.grey;
  return grey;
}
