import 'package:flutter/material.dart';
import 'package:grats_app/domain/groups.dart';
import 'package:grats_app/presentation/group/item/group_item_model.dart';
import 'package:grats_app/presentation/group/scaffoldwrapper_page.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class GroupItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupItemModel>(
      create: (_) => GroupItemModel(null)..getItems(),
      child: Consumer<GroupItemModel>(
        builder: (context, model, child) {
          final List<Items>? headers = model.items;
          if (headers == null) {
            return CircularProgressIndicator();
          }
          final List<Widget> widgets = headers
              .map(
                (header) => ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GroupItemPage()),
                    );
                  },
                  leading: Text(header.iName1),
                  title: Text(header.iName2),
                  trailing: Icon(Icons.edit),
                ),
              )
              .toList();

          return ScaffoldWrapper(
            wrap: model.controller == null,
            title: 'Folder-name',
            dlgtitle: 'Folderを追加',
            tags:'ok',
            child: ListView.builder(
              primary: model.controller == null,
              controller: model.controller,
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.grey[300],
                  child: StickyHeaderBuilder(
                    overlapHeaders: true,
                    controller: model.controller, // Optional
                    builder: (BuildContext context, double stuckAmount) {
                      stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
                      return Stack(children: [
                        Container(
                          height: 50.0,
                          color: Colors.grey.shade900
                              .withOpacity(0.6 + stuckAmount * 0.4),
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Header #$index',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                          ),
                        ),
                      ]);
                    },
                    content: Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      height: 200.0,
                      child: Column(
                        children: [
                          Text(''),
                        ],
                      ),
                      //child: ListView(
                      //children: widgets,
                      //),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
