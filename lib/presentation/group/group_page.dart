import 'package:flutter/material.dart';
import 'package:grats_app/domain/groups.dart';
import 'package:grats_app/presentation/group/folder/group_folder_page.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:grats_app/presentation/group/scaffoldwrapper_page.dart';
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
        create: (_) => GroupModel()..getGroups(),
        child: Consumer<GroupModel>(builder: (context, model, child) {
          final List<Groups>? groups = model.groups;
          if (groups == null) {
            return CircularProgressIndicator();
          }
          final List<Widget> widgets = groups
              .map(
                (group) => ListTile(
                 onTap: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => GroupFloderPage()),
                   );
                 },
                  leading: Text(group.groupname),
                  title: Text(group.groupDesc),
                  trailing: Icon(Icons.edit),
                ),
              )
              .toList();
          return ScaffoldWrapper(
            wrap: controller == null,
            title: 'Groups',
            dlgtitle: 'Groupを追加',
            child: Center(
              child: ListView(
                  children: widgets,
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
            ),
          );
        }),
      ),
    );
  }

  void navigateTo(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }
}
