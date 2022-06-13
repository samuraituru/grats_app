import 'package:flutter/material.dart';
import 'package:grats_app/domain/myuser.dart';
import 'package:grats_app/presentation/myself/myself_account_page.dart';

import 'package:grats_app/presentation/myself/myself_model.dart';
import 'package:grats_app/presentation/testpage/stool_page.dart';
import 'package:grats_app/presentation/testpage/testpage5.dart';
import 'package:provider/provider.dart';

class MyselfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<MyselfModel>(
        create: (_) => MyselfModel()..getMyuser(),
        child: Consumer<MyselfModel>(builder: (context, model, child) {
          MyUser myuser = model.myuser;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              actions: [
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyselfAccount()),
                      );
                    }),
              ],
              title: Text('Myself'),
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(45.0),
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: Material(
                              //ClipRRectの実装を検討
                              color: Colors.transparent,
                              child: InkWell(
                                child: Icon(Icons.add,
                                    size: 40, color: Colors.white),
                                onTap: () async {},
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Column(
                      children: [
                        Container(
                          child: Text('プロフィール名'),
                        ),
                        SizedBox(height: 10.0, width: 140.0),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints.expand(height: 45.0, width: 140.0),
                          child: Container(
                            color: Colors.grey,
                            child: TextField(
                              onChanged: (text){
                                myuser.userName = text;
                              },
                              decoration: InputDecoration(
                                hintText: myuser.userName != null
                                    ? '${myuser.userName}'
                                    : 'プロフィール名',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  color: Colors.grey,
                  child: TextField(
                    onChanged: (text){
                      myuser.target = text;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(30),
                      hintText: myuser.target != null
                          ? '${myuser.target}'
                          : '目標・ひとことコメント',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    model.updateMyselfInfo(myuser);
                  },
                  child: Text('プロフィールを更新'),
                ),
                ElevatedButton(onPressed: () {}, child: Text('MyRecordへ')),
                ElevatedButton(onPressed: () {}, child: Text('Groupへ')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    child: Text('Movieへ')),
              ],
            ),
          );
        }),
      ),
    );
  }
}
