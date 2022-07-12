import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/movie/browser/movie_browser_page.dart';
import 'package:grats_app/presentation/movie/local/movie_local_page.dart';
import 'package:grats_app/presentation/movie/movie_model.dart';
import 'package:grats_app/presentation/slide_left_route.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieModel>(
      create: (_) => MovieModel(),
      child: Consumer<MovieModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Movie'),
          ),
          body: Container(
            color: ThemeColors.backGroundColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: ListTile(
                          //dense: true,
                          leading: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [Icon(Icons.public_outlined,size: 35),]),
                          title: Text('ブラウザで視聴'),
                          onTap: () {
                            Navigator.push(
                                context,
                                SlideLeftRoute(
                                    exitPage: this, enterPage: MovieBrowserPage()));
                          }, // タップ
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.smartphone,size: 35),
                          title: Text('ローカルで視聴'),
                          onTap: () {
                            Navigator.push(
                                context,
                                SlideLeftRoute(
                                    exitPage: this, enterPage: MovieLocalPage()));
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
