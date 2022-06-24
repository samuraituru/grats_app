import 'package:flutter/material.dart';
import 'package:grats_app/presentation/login/login_page.dart';
import 'package:grats_app/presentation/signup/sign_model.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:  createTheme(),
      home: ChangeNotifierProvider<SignModel>(
        create: (_) => SignModel(),
        child: Consumer<SignModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('新規登録',style: TextStyle(color: ThemeColors.textColor)),
            ),
            body: Stack(
              children: [
                Container(
                  color: ThemeColors.backGroundColor,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        onChanged: (text) {
                          model.setEmail(text);
                        },
                        controller: model.titleController,
                        decoration: InputDecoration(
                          labelText: 'メールアドレス',
                          fillColor: ThemeColors.textColor,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ThemeColors.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        obscureText: true,
                        // パスワードが見えないようにする
                        maxLength: 20,
                        // 入力可能な文字数
                        onChanged: (text) {
                          model.setPassword(text);
                        },
                        controller: model.authorController,
                        decoration: InputDecoration(
                          labelText: 'パスワード',
                          fillColor: ThemeColors.textColor,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ThemeColors.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ThemeColors.color, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () async {
                        model.startLoading();
                        // 追加の処理
                        try {
                          await model.signUp();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginPage()));
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } finally {
                          model.endLoading();
                        }
                      },
                      child: Text('登録する'),
                    ),
                    if (model.isLoading)
                      Container(
                        color: Colors.black54,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ThemeColors.color,
                          onPrimary: Colors.white,
                          shape: const StadiumBorder(),
                          side: const BorderSide(color: Colors.greenAccent),
                        ),
                        child: Text('ログイン画面へ'),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
