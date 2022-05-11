import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/browser/movie_browser_model.dart';
import 'package:grats_app/presentation/movie/movie_page.dart';
import 'package:provider/provider.dart';

class MovieBrowserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<MovieBrowserModel>(
        create: (_) => MovieBrowserModel(),
        child: Consumer<MovieBrowserModel>(builder: (context, model, child) {
          return Scaffold(
            body: Column(
              children: [
                SafeArea(
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
              ],
            ),
          );
        }),
      ),
    );
  }
}
