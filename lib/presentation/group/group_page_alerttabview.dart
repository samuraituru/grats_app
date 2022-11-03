import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:grats_app/presentation/group/group_page.dart';
import 'package:provider/provider.dart';

class AlertTabView extends StatelessWidget {
  const AlertTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupModel>(
      create: (_) => GroupModel(),
      child: Consumer<GroupModel>(builder: (context, model, child) {
        final List<TabInfo> _tabs = [
          TabInfo(
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
                        padding: const EdgeInsets.all(20),
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
                              return const CircleAvatar(
                                radius: 30,
                                backgroundColor: ThemeColors.whiteColor,
                                child: Icon(Icons.add,
                                    size: 40, color: Colors.grey),
                              );
                            })(),
                          ),
                        ),
                      ),
                      TextField(
                        controller: model.groupNameController,
                        //textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.group),
                          labelText: 'group名を記載',
                          //fillColor: ThemeColors.backGroundColor,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                //color: ThemeColors.whiteColor,
                                ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10.0)),
                      TextField(
                        controller: model.groupDescController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.comment),
                          labelText: '説明を記載',
                          //fillColor: ThemeColors.backGroundColor,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 40,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
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
          ),
          TabInfo(
            "コードから参加",
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(10.0)),
                const Text('参加するグループのコードを入力'),
                TextField(
                  controller: model.groupCordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.group),
                    labelText: 'グループコード',
                    //fillColor: ThemeColors.backGroundColor,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          //color: ThemeColors.whiteColor,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ];
        return AlertDialog(
          //insetPadding: EdgeInsets.zero,
          content: SizedBox(
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
                        preferredSize: const Size.fromHeight(20.0),
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
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  try {
                    await model.modalFinishActions();
                  } catch (e) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } finally {
                    model.endLoading();
                    Navigator.pop(context);
                    model.controllerReset();
                  }
                  setState(() {});
                },
              );
            }),
          ],
        );
      }),
    );
  }
}
