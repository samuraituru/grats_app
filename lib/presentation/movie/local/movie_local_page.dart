import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/local/movie_local_model.dart';
import 'package:grats_app/presentation/movie/movie_page.dart';
import 'package:provider/provider.dart';

class MovieLocalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<MovieLocalModel>(
        create: (_) => MovieLocalModel(),
        child: Consumer<MovieLocalModel>(builder: (context, model, child) {
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
        }),
      ),
    );
  }
  Widget _buildVertical(BuildContext context) {
    // 縦向きの場合
    return Column(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MoviePage()),
            );
          },
        ),
        Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: Text("タテ", style: TextStyle(fontSize: 32)),
        ),
      ],
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    // 横向きの場合
    return Container(
      alignment: Alignment.center,
      color: Colors.pink,
      child: Text("ヨコ", style: TextStyle(fontSize: 32)),
    );
  }
}
