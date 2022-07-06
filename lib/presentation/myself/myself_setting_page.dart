import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/myself/myself_model.dart';
import 'package:provider/provider.dart';

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
                title: Text('プライバシーポリシー'),
                onTap: () {},
              ),
              Visibility(
                visible: (model.isLogin),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('アカウント削除',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
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
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    } finally {
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    ListTile(
                      title: Text('ログアウト',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
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
                        } finally {
                        }
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
