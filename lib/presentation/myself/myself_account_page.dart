import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/presentation/myself/myself_model.dart';
import 'package:grats_app/presentation/myself/myself_page.dart';
import 'package:provider/provider.dart';

class MyselfAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<MyselfModel>(
          create: (_) => MyselfModel(),
          child: Consumer<MyselfModel>(builder: (context, model, child) {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(icon:Icon(Icons.arrow_back_ios),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyselfPage()),
                    );
                  }),
                  centerTitle: true,
                  title: Text('アカウント詳細'),
                ),
                body: ListView(
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
                      title: Text('ログアウト'),
                      onTap: ()async {
                       await FirebaseAuth.instance.signOut();
                      },
                    ),
                  ],
                ),
              );
            }
          ),
      ),
    );
  }
}
