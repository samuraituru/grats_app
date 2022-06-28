import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:grats_app/presentation/group/group_page.dart';
import 'package:grats_app/presentation/group/group_page_dialog_tab2.dart';
import 'package:provider/provider.dart';

class GroupPageDialogTab1 extends StatelessWidget {
  const GroupPageDialogTab1({context, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupModel>(
      create: (_) => GroupModel(),
      child: Consumer<GroupModel>(builder: (context, model, child) {
        return SingleChildScrollView(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque, //画面外タップを検知するために必要
            onTap: () => FocusScope.of(context).unfocus(),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () async {
                        await model.pickImage();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12, //枠線の色
                            width: 5, //枠線の太さ
                          ),
                          shape: BoxShape.circle,
                          //color: Colors.blue,
                        ),
                        height: 100,
                        width: 100,
                        child: (() {
                          //imageFileがNullでないつまり、画像選択時は下記を実行
                          if (model.imageFile != null) {
                            return ClipOval(
                              child: Image.file(model.imageFile!),
                            );
                          }
                          //imageFileがNullつまり、選択していない時は下記を実施
                          return CircleAvatar(
                            radius: 30,
                            backgroundColor: ThemeColors.whiteColor,
                            child:
                                Icon(Icons.add, size: 40, color: Colors.grey),
                          );
                        })(),
                      ),
                    ),
                  ),
                  TextField(
                    onChanged: (name) {
                      setState(() {
                        model.setName(name);
                        //model.groupName = name;
                      });
                    },
                    controller: model.groupNameController,
                    //textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      labelText: 'group名を記載',
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
                  Padding(padding: EdgeInsets.all(10.0)),
                  TextField(
                    onChanged: (desc) {
                      model.groupDesc = desc;
                    },
                    controller: model.groupDescController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.comment),
                      labelText: '説明を記載',
                      //fillColor: ThemeColors.backGroundColor,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 40,
                      ),
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
            }),
          ),
        );
      }),
    );
  }
}

class Alert extends StatelessWidget {
  const Alert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<GroupModel>(
      create: (_) => GroupModel(),
      child: Consumer<GroupModel>(builder: (context, model, child) {
        final List<TabInfo> _tabs = [
          TabInfo("グループ作成", GroupPageDialogTab1(context: context)),
          /*TabInfo(
            "グループ作成",
            SingleChildScrollView(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque, //画面外タップを検知するために必要
                onTap: () => FocusScope.of(context).unfocus(),
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: GestureDetector(
                              onTap: () async {
                                await model.pickImage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12, //枠線の色
                                    width: 5, //枠線の太さ
                                  ),
                                  shape: BoxShape.circle,
                                  //color: Colors.blue,
                                ),
                                height: 100,
                                width: 100,
                                child: (() {
                                  //imageFileがNullでないつまり、画像選択時は下記を実行
                                  if (model.imageFile != null) {
                                    return ClipOval(
                                      child: Image.file(model.imageFile!),
                                    );
                                  }
                                  //imageFileがNullつまり、選択していない時は下記を実施
                                  return CircleAvatar(
                                    radius: 30,
                                    backgroundColor: ThemeColors.whiteColor,
                                    child:
                                    Icon(Icons.add, size: 40, color: Colors.grey),
                                  );
                                })(),
                              ),
                            ),
                          ),
                          TextField(
                            onChanged: (name) {
                              setState(() {
                                model.setName(name);
                                //model.groupName = name;
                              });
                            },
                            controller: model.groupNameController,
                            //textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.group),
                              labelText: 'group名を記載',
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
                          Padding(padding: EdgeInsets.all(10.0)),
                          TextField(
                            onChanged: (desc) {
                              model.groupDesc = desc;
                            },
                            controller: model.groupDescController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.comment),
                              labelText: '説明を記載',
                              //fillColor: ThemeColors.backGroundColor,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 40,
                              ),
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
                    }),
              ),
            ),
          ),*/
          TabInfo("コードから参加", GroupPageDialogTab2()),
        ];
        return AlertDialog(
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
                    children: _tabs.map((tab) => tab.widget).toList()),
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
        );
      }),
    );
  }
}
