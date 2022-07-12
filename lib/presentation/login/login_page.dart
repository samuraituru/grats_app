import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/login/login_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Consumer<LoginModel>(builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: ThemeColors.whiteColor),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/signUp'),
            ),
            title: Text(
              'Login',
              style: TextStyle(color: ThemeColors.whiteColor),
            ),
          ),
          body: Center(
            child: Stack(
              children: [
                Container(
                  color: ThemeColors.whiteColor,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Text('LogIn Now',
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
                          ],
                          // 入力可能な文字数
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
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        fixedSize: Size(200.0, 50.0),
                        primary: Colors.black,
                        onPrimary: Colors.white,
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      onPressed: () async {
                        model.startLoading();
                        // 追加の処理
                        try {
                          await model.login();
                          Navigator.of(context).pushReplacementNamed("/home");
                        } catch (error) {
                          print(error);
                          if (error.toString() == model.errorCode[1]) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content:
                                  Text('フォーマットが適切ではありません\n${error.toString()}'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          if (error.toString() == model.errorCode[2]) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content:
                                  Text('メールアドレスが既に登録済みです\n${error.toString()}'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          if (error.toString() == model.errorCode[3]) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content:
                                  Text('登録されていないアドレスです\n${error.toString()}'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } finally {
                          model.endLoading();
                        }
                      },
                      child: Text(
                        'LogIn',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              backgroundColor: ThemeColors.cyanSubColor,
                              enableDrag: true,
                              isDismissible: false,
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return EmailResetModal();
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text('パスワードを忘れましたか？'),
                        )),
                    if (model.isLoading)
                      Container(
                        color: ThemeColors.whiteColor,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class EmailResetModal extends StatelessWidget {
  const EmailResetModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
        create: (_) => LoginModel(),
    child: Consumer<LoginModel>(builder: (context, model, child) {
            return Column(
              children: [
                Padding(padding: EdgeInsets.all(100.0),),
                Icon(Icons.mail,size: 90,color: ThemeColors.whiteColor),
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text('パスワード再設定メール送信',
                      style: TextStyle(
                        color: ThemeColors.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
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
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    fixedSize: Size(200.0, 50.0),
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  onPressed: () async {
                      String _result = await model.sendPasswordResetEmail();
                      // 成功時は戻る
                      if (_result == 'success') {
                        Navigator.pop(context);
                      } else if (_result == 'ERROR_INVALID_EMAIL') {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content:
                          Text("無効なメールアドレスです"),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      } else if (_result == 'ERROR_USER_NOT_FOUND') {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content:
                          Text("メールアドレスが登録されていません"),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content:
                          Text("メール送信に失敗しました"),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      }
                  },
                  child: Text(
                    'メール送信',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                if (model.isLoading)
                  Container(
                    color: ThemeColors.whiteColor,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          }
        ),
    );
  }
}
