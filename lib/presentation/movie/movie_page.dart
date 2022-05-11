import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/browser/movie_browser_page.dart';
import 'package:grats_app/presentation/movie/local/movie_local_page.dart';
import 'package:grats_app/presentation/movie/movie_model.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<MovieModel>(
        create: (_) => MovieModel(),
        child: Consumer<MovieModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Movie'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('タイトル'),
                            content: TextField(
                              decoration: InputDecoration(hintText: "ここに入力"),
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
                                  //OKを押したあとの処理
                                },
                              ),
                            ],
                          );
                        });
                  },
                )
              ],
            ),
            body: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey))),
                  child: ListTile(
                    leading: Icon(Icons.public_outlined),
                    title: Text('browserで視聴'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MovieBrowserPage()),
                      );
                    }, // タップ
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey))),
                  child: ListTile(
                    leading: Icon(Icons.smartphone),
                    title: Text('ローカルで視聴'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MovieLocalPage()),
                      );
                    }, // タップ
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
