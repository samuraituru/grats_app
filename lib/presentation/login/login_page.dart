import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/home/home_page.dart';
import 'package:grats_app/presentation/login/login_model.dart';
import 'package:grats_app/presentation/record/record_page.dart';
import 'package:grats_app/presentation/signup/signup_page.dart';
import 'package:grats_app/presentation/slide_right_route.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: createTheme(),
      home: ChangeNotifierProvider<LoginModel>(
        create: (_) => LoginModel(),
        child: Consumer<LoginModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,color: ThemeColors.textColor),
                onPressed: () {
                  Navigator.push(context, SlideRightRoute(page: SignUpPage()));
                },
              ),
              title: Text(
                'ログイン',
                style: TextStyle(color: ThemeColors.textColor),
              ),
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
                      onPressed: () async {
                        model.startLoading();
                        // 追加の処理
                        try {
                          await model.login();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } catch (e) {
                          print(e);
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } finally {
                          model.endLoading();
                        }
                      },
                      child: Text(
                        'ログイン',
                        style: TextStyle(color: ThemeColors.textColor),
                      ),
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
              ],
            ),
          );
        }),
      ),
    );
  }
}
