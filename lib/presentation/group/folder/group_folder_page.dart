import 'package:flutter/material.dart';
import 'package:grats_app/presentation/group/folder/group_folder_model.dart';
import 'package:grats_app/presentation/group/item/group_item_page.dart';
import 'package:grats_app/presentation/group/scaffoldwrapper_page.dart';
import 'package:provider/provider.dart';


class GroupFloderPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupFolderModel>(
        create: (_) => GroupFolderModel(null)..getGroups(),
        child: Consumer<GroupFolderModel>(builder: (context, model, child) {
          return ScaffoldWrapper(
              wrap: model.controller == null,
              title: model.groupname,
              dlgtitle:'Itemを追加',
              child: ListView(
                  children: [
                    ListTile(
                      title: const Text(
                          'Folder-Page'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GroupItemPage()),
                        );
                      },
                    ),
                  ]
              ),
            );
          }
        ),
    );
  }
}