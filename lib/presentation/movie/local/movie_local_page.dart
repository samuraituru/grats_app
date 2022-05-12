import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/local/movie_local_model.dart';
import 'package:provider/provider.dart';

class MovieLocalPage extends StatelessWidget {
  //bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<MovieLocalModel>(
        create: (_) => MovieLocalModel(),
        child: Consumer<MovieLocalModel>(
          builder: (context, model, child) {
            final String? task = model.task;
            final List<Task> tasks = model.tasks;

            if (task == null) {
              return CircularProgressIndicator();
            }

            final List<Task> widget = tasks;
            ListTile(
                title: Text(''),
              );
            return ListView(
              children: widget,
            );
/*
          return Scaffold(
            body: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return constraints.maxWidth < constraints.maxHeight
                        ? _buildVertical(context)
                        : _buildHorizontal(context);
                  },
                ),
              ],
            ),
          );
*/
            return Scaffold(
              // AppBarを表示し、タイトルも設定
              appBar: AppBar(
                title: Text('リスト一覧'),
              ),
              // データを元にListViewを作成
              body: Column(
                children: [
                  TextField(
                    // 入力されたテキストの値を受け取る（valueが入力されたテキスト）
                    onChanged: (String value) {
                      // データが変更したことを知らせる（画面を更新する）
                      // データを変更
                      model.task = value;
                    },
                  ),
                ],
              ),

              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  try {
                    await model.addbook();
                    final snackbar = SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('本を追加しました。'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  } catch(e) {
                    final snackbar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                },
                child: Icon(Icons.add),
              ),
            );


            // 縦向きの場合
            /*
    return Column(
      children: [
        SafeArea(
          child: Container(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MoviePage()),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 250,
          child: Container(
            child: Material(
              color: Colors.red,
              child: InkWell(
                onTap: () async {},
              ),
            ),
          ),
        ),
      ],
    );
  }
*/
            Widget _buildHorizontal(BuildContext context) {
              // 横向きの場合
              return Container(
                alignment: Alignment.center,
                color: Colors.pink,
                child: Text("ヨコ", style: TextStyle(fontSize: 32)),
              );
            }
          },
        ),
      ),
    );
  }
}
