import 'package:flutter/material.dart';
import 'package:grats_app/presentation/group/item/group_item_model.dart';
import 'package:grats_app/presentation/group/scaffoldwrapper_page.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class GroupItemPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupItemModel>(
      create: (_) => GroupItemModel(null),
      child: Consumer<GroupItemModel>(
        builder: (context, model, child) {
          return ScaffoldWrapper(
            wrap: model.controller == null,
            title: 'Folder-name',
            dlgtitle: 'Folderを追加',
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
                      return Container(
                        height: 50.0,
                        color: Colors.grey.shade900
                            .withOpacity(0.6 + stuckAmount * 0.4),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Header #$index',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    content: Container(
                      width: 100,
                      height: 100,
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
