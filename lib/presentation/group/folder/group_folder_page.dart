import 'package:flutter/material.dart';
import 'package:grats_app/domain/groups.dart';
import 'package:grats_app/presentation/group/folder/group_folder_model.dart';
import 'package:grats_app/presentation/group/item/group_item_page.dart';
import 'package:grats_app/presentation/group/scaffoldwrapper_page.dart';
import 'package:provider/provider.dart';

class GroupFloderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupFolderModel>(
      create: (_) => GroupFolderModel(null)..getFolder(),
      child: Consumer<GroupFolderModel>(builder: (context, model, child) {
        final List<Folders>? folders = model.folders;
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
                leading: Text(folder.fName),
                title: Text(folder.fDesc),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){},
                ),
              ),
            )
            .toList();

        return ScaffoldWrapper(
          wrap: model.controller == null,
          title: '',
          dlgtitle: 'Itemを追加',
          tags:'ok',
          child: ListView(
            children: widgets,
/*
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
*/
              ),
        );
      }),
    );
  }
}
