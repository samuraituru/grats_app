import 'package:flutter/material.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:provider/provider.dart';

class GroupPageDialogTab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupModel>(
      create: (_) => GroupModel(),
      child: Consumer<GroupModel>(
        builder: (context, model, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10.0)),
              Text('参加するグループのコードを入力'),
              TextField(
                controller: model.groupCordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.group),
                  labelText: 'グループコード',
                  //fillColor: ThemeColors.backGroundColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        //color: ThemeColors.whiteColor,
                        ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
