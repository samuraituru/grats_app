import 'package:flutter/material.dart';
import 'package:grats_app/presentation/login/login_page.dart';
import 'package:grats_app/presentation/signup/sign_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<SignModel>(
        create: (_) => SignModel(),
        child: Consumer<SignModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('新規登録'),
            ),
            body: Column(
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
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    obscureText: true, // パスワードが見えないようにする
                    maxLength: 20, // 入力可能な文字数
                    onChanged: (text) {
                      model.setPassword(text);
                    },
                    controller: model.authorController,
                    decoration: InputDecoration(
                      labelText: 'パスワード',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () async {
                    model.startLoading();
                    // 追加の処理
                    try {
                      await model.signUp();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()));
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
                ElevatedButton(
                  child: Text('ログイン画面へ'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
