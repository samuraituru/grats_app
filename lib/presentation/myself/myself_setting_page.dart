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
                title: Text('profile'),
                onTap: () {},
              ),
              ListTile(
                title: Text('プライバシーポリシー'),
                onTap: () {},
              ),
              ListTile(
                title: Text('ログアウト',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                onTap: () async {
                  model.startLoading();
                  // 追加の処理
                  try {
                    await model.signOut(context);
                    Navigator.of(context).pushReplacementNamed('/login');
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
              ),
              if (model.isLoading)
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Container(
                    color: ThemeColors.whiteColor,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
