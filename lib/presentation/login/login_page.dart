import 'package:flutter/material.dart';
import 'package:grats_app/presentation/login/login_model.dart';
import 'package:grats_app/presentation/record/record_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<LoginModel>(
        create: (_) => LoginModel(),
        child: Consumer<LoginModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('ログイン'),
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
                    onChanged: (inputpass) {
                      model.setPassword(inputpass);
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
                  onPressed: () async {
                    model.startLoading();
                    // 追加の処理
                    try {
                      await model.login();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecordPage()));
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
                  child: Text('ログイン'),
                ),
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(),
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
