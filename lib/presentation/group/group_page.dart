import 'package:flutter/material.dart';
import 'package:grats_app/domain/groups.dart';
import 'package:grats_app/presentation/group/folder/group_folder_page.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({
    Key? key,
    this.controller,
  }) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<GroupModel>(
        create: (_) => GroupModel()..initAction(),
        child: Consumer<GroupModel>(
          builder: (context, model, child) {
            final List<Group>? groups = model.groups;

            if (groups == null) {
              return Container(
                child: SizedBox(
                    height: 100, width: 100, child: CircularProgressIndicator()),
              );
            }
            final List<Widget> widgets = groups
                .map(
                  (group) => ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroupFloderPage(group)),
                      );
                    },
                    leading: Text('${group.gName}'),
                    title: Text(group.gDesc!),
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
                  title: Text('Groups'),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        model.initlist();
                        /*showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Groupを追加'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: " 追加",
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 20,
                                      ),
                                    ),
                                    onChanged: (text) {
                                      model.addgName = text;
                                    },
                                  ),
                                  Padding(padding: EdgeInsets.all(10.0)),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: " 説明",
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

                                  },
                                ),
                              ],
                            );
                          },
                        );*/
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

/*
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      title: Text(''),
                      onTap: () =>
                          navigateTo(context, (context) => GroupFloderPage()),
                    ),
                  ],
                ).toList(growable: false),
*/
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
