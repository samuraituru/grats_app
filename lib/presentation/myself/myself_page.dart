import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/myself/myself_model.dart';
import 'package:grats_app/presentation/myself/myself_setting_page.dart';
import 'package:grats_app/presentation/slide_left_route.dart';
import 'package:provider/provider.dart';

class MyselfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyselfModel>(
      create: (_) => MyselfModel()..fetchMyUser(),
      child: Consumer<MyselfModel>(builder: (context, model, child) {
        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.width;
        double appbarHeight = AppBar().preferredSize.height;
        print('screenHeightは$screenHeight');
        print('screenWidthは$screenWidth');
        print('appbarHeightは$appbarHeight');

        //int? tabIndex = DefaultTabController.of(context)?.index;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Mypage'),
          ),
          body: LayoutBuilder(
            builder: ((context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque, //画面外タップを検知するために必要
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: screenWidth,
                              height: screenHeight / 2 + 20,
                              color: ThemeColors.cyanColor,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    !model.isLogin
                                        ? GestureDetector(
                                            onTap: () async =>
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        "/signUp"),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue,
                                              ),
                                              height: 55,
                                              width: 55,
                                              child: const CircleAvatar(
                                                backgroundColor:
                                                    ThemeColors.cyanSubColor,
                                                child: Icon(Icons.login,
                                                    size: 30,
                                                    color:
                                                        ThemeColors.whiteColor),
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () async =>
                                                model.fetchMyUser(),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              height: 55,
                                              width: 55,
                                              child: const CircleAvatar(
                                                backgroundColor:
                                                    ThemeColors.cyanSubColor,
                                                child: Icon(Icons.refresh,
                                                    size: 30,
                                                    color:
                                                        ThemeColors.whiteColor),
                                              ),
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: SizedBox(
                                        height: 120,
                                        width: 120,
                                        child: (() {
                                          //ログインをしていない場合
                                          if (!model.isLogin) {
                                            return Container(
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
                                              child: const CircleAvatar(
                                                radius: 30,
                                                backgroundColor:
                                                    ThemeColors.cyanSubColor,
                                                child: Icon(Icons.person,
                                                    size: 80,
                                                    color: Colors.white),
                                              ),
                                            );
                                          }
                                          //ログインしている場合
                                          return GestureDetector(
                                            onTap: () async {
                                              await model.pickImage();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: ThemeColors
                                                      .whiteColor, //枠線の色
                                                  width: 5, //枠線の太さ
                                                ),
                                                shape: BoxShape.circle,
                                                //color: Colors.blue,
                                              ),
                                              height: 100,
                                              width: 100,
                                              child: (() {
                                                //imageFileにデータが存在する場合
                                                if (model.imageFile != null) {
                                                  return Stack(
                                                    children: [
                                                      //imageを表示する
                                                      ClipOval(
                                                        child: Image.file(
                                                            model.imageFile!),
                                                      ),
                                                      //ゴミ箱を表示する
                                                      GestureDetector(
                                                        onTap: () {
                                                          model
                                                              .deleteImageFile();
                                                        },
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 40,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .white,
                                                                //枠線の色
                                                                width:
                                                                    3, //枠線の太さ
                                                              ),
                                                              shape: BoxShape
                                                                  .circle,
                                                              //color: Colors.blue,
                                                            ),
                                                            child:
                                                                const CircleAvatar(
                                                              backgroundColor:
                                                                  ThemeColors
                                                                      .cyanSubColor,
                                                              child: Icon(
                                                                  Icons
                                                                      .delete_forever,
                                                                  //size: 80,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                                //FireStoreの値がNullの場合つまり初期値の場合
                                                else if (model.myUser.imgURL ==
                                                    '') {
                                                  return const CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor: ThemeColors
                                                        .cyanSubColor,
                                                    child: Icon(Icons.add,
                                                        size: 40,
                                                        color: Colors.white),
                                                  );
                                                }
                                                //プロフィールにimgURLがある場合は下記を実行
                                                return CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: NetworkImage(
                                                      model.myUser.imgURL),
                                                );
                                              })(),
                                            ),
                                          );
                                        })(),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            SlideLeftRoute(
                                                exitPage: this,
                                                enterPage: MyselfSetting()));
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                        height: 55,
                                        width: 55,
                                        child: (() {
                                          return const CircleAvatar(
                                            backgroundColor:
                                                ThemeColors.cyanSubColor,
                                            child: Icon(Icons.settings,
                                                size: 30,
                                                color: ThemeColors.whiteColor),
                                          );
                                        })(),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ConstrainedBox(
                                        constraints:
                                            const BoxConstraints.expand(
                                                height: 60.0, width: 200.0),
                                        child: TextFormField(
                                          //textAlign: TextAlign.center,
                                          enabled: model.isLogin,
                                          controller: model.userNameController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: const Icon(Icons.person,
                                                color: ThemeColors.whiteColor),
                                            hintText: (() {
                                              if (!model.isLogin) {
                                                return 'ゲストアカウント';
                                              } else if (model
                                                      .myUser.userName ==
                                                  "") {
                                                return '名前未設定';
                                              }
                                              return model.myUser.userName;
                                            })(),
                                            hintStyle: const TextStyle(
                                                color: ThemeColors.whiteColor),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      ThemeColors.whiteColor),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      ThemeColors.whiteColor),
                                            ),
                                            disabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      ThemeColors.whiteColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints: const BoxConstraints.expand(
                                          height: 80.0, width: 200.0),
                                      child: TextFormField(
                                        enabled: model.isLogin,
                                        controller: model.userTargetController,
                                        keyboardType: TextInputType.multiline,
                                        //キーボードを複数行対応にする
                                        //maxLines: 3,
                                        //TextFieldで複数行表示する
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: const Icon(Icons.comment,
                                              color: ThemeColors.whiteColor),
                                          //filled: true,
                                          //fillColor: ThemeColors.whiteColor,
                                          //contentPadding: EdgeInsets.all(20),
                                          hintText: (() {
                                            if (!model.isLogin) {
                                              return 'ゲストアカウント';
                                            } else if (model
                                                    .myUser.userTarget ==
                                                "") {
                                              return '目標\nひとことコメント';
                                            }
                                            return model.myUser.userTarget;
                                          })(),
                                          hintStyle: const TextStyle(
                                              color: ThemeColors.whiteColor),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ThemeColors.whiteColor),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ThemeColors.whiteColor),
                                          ),
                                          disabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ThemeColors.whiteColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    (model.isLogin)
                                        ? ElevatedButton(
                                            onPressed: () async {
                                              model.startLoading();
                                              // 追加の処理
                                              try {
                                                await model.userInfoUpdate();
                                              } catch (e) {
                                                final snackBar = SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(e.toString()),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              } finally {
                                                model.endLoading();
                                                await model.fetchMyUser();
                                              }
                                            },
                                            child: const Text('プロフィールを更新',
                                                style: TextStyle(
                                                    color: ThemeColors
                                                        .whiteColor)),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                            /*Center(
                                child: (model.isLoading)
                                    ? SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      )
                                    : SizedBox()),*/
                          ],
                        ),
                        /*ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  SlideLeftRoute(
                                      exitPage: this, enterPage: TestMovieBrowserPage()));
                            },
                            child: Text('MyRecordへ')),*/
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                        ),
                        Card(
                          color: ThemeColors.backGroundColor,
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                title: Text(
                                    '現在の合計レコード数 : ${model.folderLength ?? '0'}'),
                                subtitle: Text(
                                    '現在の合計アイテム数 : ${model.itemLength ?? '0'}'),
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
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
