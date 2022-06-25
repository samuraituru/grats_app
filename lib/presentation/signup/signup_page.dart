import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grats_app/presentation/login/login_page.dart';
import 'package:grats_app/presentation/signup/signUp_model.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: createTheme(),
      home: ChangeNotifierProvider<SignUpModel>(
        create: (_) => SignUpModel(),
        child: Consumer<SignUpModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('SignUp',
                  style: TextStyle(color: ThemeColors.whiteColor)),
            ),
            body: Center(
              child: Stack(
                children: [
                  Container(
                    color: ThemeColors.backGroundColor,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Text('Welcome to\nSignUp-Page',
                            style: TextStyle(
                              fontFamily: 'Courgette',
                              fontSize: 30,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: (text) {
                              model.setEmail(text);
                            },
                            controller: model.emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              labelText: 'メールアドレス',
                              fillColor: ThemeColors.whiteColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: ThemeColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            obscureText: model.isObscure,
                            // パスワードが見えないようにする
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(20)
                              ],// 入力可能な文字数
                            onChanged: (text) {
                              model.setPassword(text);
                            },
                            controller: model.passwordController,
                            decoration: InputDecoration(
                              labelText: 'パスワード',
                              prefixIcon: Icon(Icons.lock_open),
                              suffixIcon: IconButton(
                                // 文字の表示・非表示でアイコンを変える
                                icon: Icon(model.isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                // アイコンがタップされたら現在と反対の状態をセットする
                                onPressed: () {
                                  model.changeObscure();
                                },
                              ),
                              fillColor: ThemeColors.whiteColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: ThemeColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          fixedSize: Size(200.0, 50.0),
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          shape: const StadiumBorder(),
                          side: const BorderSide(color: Colors.black87),
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } finally {
                            model.endLoading();
                          }
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      if (model.isLoading)
                        Container(
                          color: ThemeColors.whiteColor,
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
                          child: Text('Loin'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
