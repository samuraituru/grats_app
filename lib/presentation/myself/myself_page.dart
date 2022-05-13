import 'package:flutter/material.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:grats_app/presentation/myself/myself_model.dart';
import 'package:provider/provider.dart';

class MyselfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<MyselfModel>(
        create: (_) => MyselfModel(),
        child: Consumer<MyselfModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
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
                              decoration: const InputDecoration(
                                hintText: '   プロフィール名',
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
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(30),
                      hintText: '目標・ひとことコメント',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('プロフィールを更新'),
                ),
                ElevatedButton(onPressed: () {}, child: Text('MyRecordへ')),
                ElevatedButton(onPressed: () {}, child: Text('Groupへ')),
                ElevatedButton(onPressed: () {}, child: Text('Movieへ')),
              ],
            ),
          );
        }),
      ),
    );
  }
}
