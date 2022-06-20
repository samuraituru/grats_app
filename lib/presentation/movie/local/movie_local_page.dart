import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/local/local_countItem_widget.dart';
import 'package:grats_app/presentation/movie/local/movie_local_model.dart';
import 'package:grats_app/presentation/movie/local/watch_widget.dart';
import 'package:grats_app/presentation/movie/movie_page.dart';
import 'package:provider/provider.dart';

class MovieLocalPage extends StatelessWidget {
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
      return Column(
        children: [
          Stack(
            children: [
              Container(
                child: WatchWidget(),
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
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Recordへ記録しますか？'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (int i = 0;
                                        i < model.countItems.length;
                                        i++) ...{
                                      Text('${model.countItems[i].title}: ${model.countItems[i].counter}'),
                                      //Text('${model.countItems[i].counter}'),
                                    },
                                    //model.outPutText(),
                                    Padding(padding: EdgeInsets.all(10.0)),
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
                                    onPressed: () {

                                    },
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
                model.title = value!;
              },
              decoration: InputDecoration(
                hintText: 'カウントしたい項目を追加',
                suffixIcon: IconButton(
                  onPressed: () {
                    model.countItemCreate();
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            ),
          ),
          Container(
            height: 375,
            child: SingleChildScrollView(
              controller: model.scrollController,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: model.countItems.length,
                itemBuilder: (BuildContext context, index) {
                  final countItem = model.countItems[index];
                  final countItems = model.countItems;
                  return CountItemWidget(
                      countItem: countItem,
                      countItems: countItems,
                      itemIndex: index);
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildVertical(BuildContext context) {
    return Consumer<MovieLocalModel>(builder: (context, model, child) {
      return Container(
        alignment: Alignment.center,
        color: Colors.pink,
        child: Text("ヨコ", style: TextStyle(fontSize: 32)),
      );
    });
  }
}
