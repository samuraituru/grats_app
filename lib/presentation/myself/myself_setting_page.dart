import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/myself/myself_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyselfSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyselfModel>(
      create: (_) => MyselfModel()..fetchMyUser(),
      child: Consumer<MyselfModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: ThemeColors.whiteColor),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            centerTitle: true,
            title: Text('Setting'),
          ),
          body: Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Icon(Icons.subject, size: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('利用規約', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                onTap: () async{
                  final termsUrl = Uri.parse(
                    'https://breezy-rover-006.notion.site/c307b48479df416ea66ba2d4bc9eb0f2',
                  );
                  try {
                    model.launchInWebViewOrVC(termsUrl);
                    /*Timer(const Duration(seconds: 10), () {
                      print('Closing WebView after 5 seconds...');
                      closeInAppWebView();
                    });*/
                  } catch (e) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } finally {}
                },
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Icon(Icons.subject, size: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('プライバシーポリシー', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                onTap: () async {
                  final privacyUrl = Uri.parse(
                    'https://breezy-rover-006.notion.site/96eb846aeb994a439d309a404cae0f4d',
                  );
                  try {
                    await model.launchInWebViewOrVC(privacyUrl);
                  } catch (e) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } finally {}
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Icon(Icons.help, size: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('通報・お問い合わせ', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                onTap: () async{
                  final formUrl = Uri.parse(
                    'https://docs.google.com/forms/d/e/1FAIpQLSenW4B7YZmwUYg-fibvZfgX5xUMoU0oHV9VCckOQBRew_mSRA/viewform?usp=sf_link',
                  );
                  try {
                    model.launchInWebViewOrVC(formUrl);
                  } catch (e) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } finally {}
                },
              ),
              Visibility(
                visible: (model.isLogin),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Icon(Icons.logout, size: 30),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('ログアウト',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      onTap: () async {
                        // 追加の処理
                        try {
                          await model.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/login", (_) => false);
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } finally {}
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Icon(Icons.person_remove, size: 30),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('アカウント削除',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('アカウント削除'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: model.emailController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.mail),
                                      labelText: 'メールアドレス',
                                      fillColor: ThemeColors.backGroundColor,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: ThemeColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.all(10.0)),
                                  TextField(
                                    controller: model.passwordController,
                                    decoration: InputDecoration(
                                      labelText: 'パスワード',
                                      prefixIcon: Icon(Icons.lock_open),
                                      fillColor: ThemeColors.backGroundColor,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: ThemeColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('キャンセル'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    model.controllerClear();
                                  },
                                ),
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () async {
                                    try {
                                      await model.deleteUser();
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, "/signUp", (_) => false);
                                    } catch (e) {
                                      print(e);
                                      final snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(e.toString()),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } finally {}
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
