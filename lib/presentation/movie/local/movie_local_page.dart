import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/local/movie_local_model.dart';
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
              body: Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return constraints.maxWidth < constraints.maxHeight
                          ? _buildHorizontal(context)
                          : _buildHorizontal(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // 縦向きの場合
  Widget _buildHorizontal(BuildContext context) {
    return Consumer<MovieLocalModel>(
      builder: (context, model, child) {
        return Column(
          children: [
            Stack(
              children: [
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: model.controller,
                onChanged: (String? value) {
                  model.actionText = value!;
                },
                decoration: InputDecoration(
                  hintText: 'カウントしたい項目を追加',
                  suffixIcon: IconButton(
                    onPressed: () {
                      model.actionClearAdd();
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: model.action.length,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  child: ListTile(
                    onLongPress: () {
                      print('longpress');
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FloatingActionButton(
                          heroTag: "hero1",
                          tooltip: 'Action!',
                          child: Icon(Icons.add), // Text()でもOK
                          onPressed: () {},
                        ),
                        Text('数'),
                        FloatingActionButton(
                          heroTag: "hero2",
                          tooltip: 'Action!',
                          child: Icon(Icons.remove), // Text()でもOK
                          onPressed: () {},
                        ),
                      ],
                    ),
                    title: Text(
                      model.action[index],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildVertical(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.pink,
      child: Text("ヨコ", style: TextStyle(fontSize: 32)),
    );
  }
}
