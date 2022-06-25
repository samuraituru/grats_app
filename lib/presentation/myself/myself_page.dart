import 'package:flutter/material.dart';
import 'package:grats_app/domain/myuser.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/myself/myself_account_page.dart';

import 'package:grats_app/presentation/myself/myself_model.dart';
import 'package:provider/provider.dart';

class MyselfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: createTheme(),
      home: ChangeNotifierProvider<MyselfModel>(
        create: (_) => MyselfModel(),
        child: Consumer<MyselfModel>(builder: (context, model, child) {
          double screenHeight = MediaQuery.of(context).size.height;
          double screenWidth = MediaQuery.of(context).size.width;
          //int? tabIndex = DefaultTabController.of(context)?.index;
          MyUser? myUser = model.myUser;
          String? uid = model.uid;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Mypage'),
            ),
            body: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: screenWidth,
                      height: screenHeight / 2,
                      color: ThemeColors.cyanColor,
                    ),
                    Column(
                      children: [
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                print('push');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                height: 55,
                                width: 55,
                                child: (() {
                                  return const CircleAvatar(
                                    backgroundColor: ThemeColors.cyanSubColor,
                                    child: Icon(Icons.settings,
                                        size: 30,
                                        color: ThemeColors.whiteColor),
                                  );
                                })(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: SizedBox(
                                height: 120,
                                width: 120,
                                child: GestureDetector(
                                  onTap: () async {
                                    await model.pickImage();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white, //枠線の色
                                        width: 5, //枠線の太さ
                                      ),
                                      shape: BoxShape.circle,
                                      //color: Colors.blue,
                                    ),
                                    height: 100,
                                    width: 100,
                                    child: (() {
                                      if (myUser?.imgURL == '') {
                                        return const CircleAvatar(
                                          radius: 30,
                                          backgroundColor:
                                              ThemeColors.cyanSubColor,
                                          child: Icon(Icons.add,
                                              size: 40, color: Colors.white),
                                        );
                                      } else if (model.imageFile != null) {
                                        return Image.file(model.imageFile!);
                                      }
                                      return /*CircleAvatar(
                                        radius: 30,
                                        child: ClipOval(
                                          child: Image.network(
                                            myUser?.imgURL ?? '',
                                          ),
                                        ),
                                      );*/
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor:
                                          ThemeColors.cyanSubColor,
                                          child: Icon(Icons.add,
                                              size: 40, color: Colors.white),
                                        );
                                    })(),
                                  ),
                                ),
                                /*Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                              child: Material(
                                //ClipRRectの実装を検討
                                color: Colors.transparent,
                                child: InkWell(
                                  child: Icon(Icons.add,
                                      size: 40, color: Colors.white),
                                  onTap: () async {},
                                ),
                              ),
                            ),*/
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyselfAccount()),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                height: 55,
                                width: 55,
                                child: (() {
                                  return const CircleAvatar(
                                    backgroundColor: ThemeColors.cyanSubColor,
                                    child: Icon(Icons.settings,
                                        size: 30,
                                        color: ThemeColors.whiteColor),
                                  );
                                })(),
                              ),
                            ),
                          ],
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints.expand(height: 45.0, width: 180.0),
                          child: TextField(
                            onChanged: (text) {
                              myUser?.userName = text;
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.person,
                                  color: ThemeColors.whiteColor),
                              hintText: uid != null
                                  ? myUser?.userName ?? '名前未設定'
                                  : 'ゲストアカウント',
                              hintStyle:
                                  TextStyle(color: ThemeColors.whiteColor),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ThemeColors.whiteColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ThemeColors.whiteColor),
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints.expand(
                              height: 100.0, width: 280.0),
                          child: TextField(
                            onChanged: (text) {
                              myUser?.target = text;
                            },
                            keyboardType: TextInputType.multiline,
                            //キーボードを複数行対応にする
                            maxLines: null,
                            //TextFieldで複数行表示する
                            decoration: InputDecoration(
                              //filled: true,
                              //fillColor: ThemeColors.whiteColor,
                              contentPadding: EdgeInsets.all(20),
                              hintText: myUser?.target != null
                                  ? '${myUser?.target}'
                                  : '目標・ひとことコメント',
                              hintStyle:
                                  TextStyle(color: ThemeColors.whiteColor),
                              enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ThemeColors.whiteColor),
                              ),
                              focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ThemeColors.whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    model.myselfInfoAdd(myUser!);
                  },
                  child: Text('プロフィールを更新'),
                ),
                /*ElevatedButton(
                    onPressed: () {
                      //DefaultTabController.of(context)?.animateTo(2);
                    },
                    child: Text('MyRecordへ')),*/
                Card(
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.add),
                        title: Text('現在のレコード数'),
                        subtitle: Text('Card SubTitle'),
                      ),
                    ],
                  ),
                  // Card自体の色
                  margin: const EdgeInsets.all(30),
                  elevation: 8,
                  // 影の離れ具合
                  shadowColor: Colors.black,
                  // 影の色
                  shape: RoundedRectangleBorder(
                    // 枠線を変更できる
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
