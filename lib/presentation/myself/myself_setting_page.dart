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
              ListTile(
                title: Text('ログアウト',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                onTap: () async {
                  // 追加の処理
                  try {
                    await model.signOut(context);
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
        );
      }),
    );
  }
}
