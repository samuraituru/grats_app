import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/local/movie_local_model.dart';
import 'package:grats_app/presentation/movie/local/scrollview_widget.dart';
import 'package:grats_app/presentation/movie/local/watch_widget.dart';
import 'package:grats_app/presentation/movie/movie_page.dart';
import 'package:provider/provider.dart';

class MovieLocalPage extends StatelessWidget {
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<MovieLocalModel>(
        create: (_) => MovieLocalModel(),
        child: Consumer<MovieLocalModel>(
          builder: (context, model, child) {
            return Scaffold(
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return constraints.maxWidth < constraints.maxHeight
                      ? _buildHorizontal(context)
                      : _buildHorizontal(context);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // 縦向きの場合
  Widget _buildHorizontal(BuildContext context) {
    return Consumer<MovieLocalModel>(builder: (context, model, child) {
      var maps = model.mapGet();
      return Column(
        children: [
          Stack(
            children: [
              Container(
                child:
                  WatchWidget(),
         /*       Container(
                  color: Colors.grey,
                 child: SizedBox(
                    width: double.infinity,
                    height: 250,
                  ),
                ),*/
              ),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoviePage()),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.addchart_outlined),
                        onPressed: () async {
                          await model.listOutput();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Recordへ記録しますか？'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('$maps'),
                                    Padding(padding: EdgeInsets.all(10.0)),
                                    Text(''),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('キャンセル'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {},
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: model.texteditingcontroller,
              onChanged: (String? value) {
                model.inputText = value!;
              },
              decoration: InputDecoration(
                hintText: 'カウントしたい項目を追加',
                suffixIcon: IconButton(
                  onPressed: () {
                    model.addItem();
                    model.clearItem();
                    model.addIndex();
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            ),
          ),
          ScrollviewWidget(),
        ],
      );
    });
  }

  Widget _buildVertical(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.pink,
      child: Text("ヨコ", style: TextStyle(fontSize: 32)),
    );
  }
}
