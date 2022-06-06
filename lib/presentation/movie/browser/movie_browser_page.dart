import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/cursor.dart';
import 'package:grats_app/presentation/movie/browser/movie_browser_model.dart';
import 'package:grats_app/presentation/movie/movie_page.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieBrowserPage extends StatelessWidget {
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<MovieBrowserModel>(
        create: (_) => MovieBrowserModel(),
        child: Consumer<MovieBrowserModel>(builder: (context, model, child) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MoviePage()),
                  );
                },
              ),
              title: !model.searchBoolean
                  ? Text('Browser')
                  : model.searchTextField(),
              actions: !model.searchBoolean
                  ? [
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            model.searchPush();
                            model.searchIndexList = [];
                          }),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          //webViewController?.reload();
                        },
                      ),
                    ]
                  : [
                      IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            model.searchPull();
                          }),
                    ],
            ),
            body: !model.searchBoolean ? BroserView() : model.searchListView(),
            floatingActionButton:
                !model.searchBoolean ? FloatingView(context) : null,
          );
        }),
      ),
    );
  }

  FloatingView(context) {
    var actionText = '';
    var action = <String>['例)反則数（長押しで削除）'];
    var controller = TextEditingController();

    return FloatingActionButton(
      child: Icon(Icons.arrow_upward),
      onPressed: () {
        showModalBottomSheet(
            //backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,
            //trueにしないと、Containerのheightが反映されない
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            builder: (BuildContext context) {
              return Container(
                height: 540,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: controller,
                        onChanged: (String? value) {
                          actionText = value!;
                        },
                        decoration: InputDecoration(
                          hintText: 'カウントしたい項目を追加',
                          suffixIcon: IconButton(
                            onPressed: () {
                              //actionClearAdd();
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: action.length,
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
                                  tooltip: 'Action!',
                                  child: Icon(Icons.add),
                                  // Text()でもOK
                                  onPressed: () {},
                                ),
                                Text('数'),
                                FloatingActionButton(
                                  tooltip: 'Action!',
                                  child: Icon(Icons.remove),
                                  // Text()でもOK
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            title: Text(
                              action[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }).whenComplete(() {
          print('Hey there, I\'m calling after hide bottomSheet');
        });
      },
    );
  }
}

class BroserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieBrowserModel>(
      create: (_) => MovieBrowserModel(),
      child: Consumer<MovieBrowserModel>(builder: (context, model, child) {
        final widget = movingCursor(model, model.cursorRed1, Colors.red);
        model.contentWidgets = createList(model);
        return Stack(children: [
          BroserWibView(),
          //movingCursor(model, model.cursorRed1, Colors.red),
          FloatingActionButton(
            tooltip: 'Action!',
            child: Icon(Icons.add),
            // Text()でもOK
            onPressed: () {
              model.widgetsAdd();
            },
          ),
          Stack(
              children: model.contentWidgets
                  ),
        ]);
      }),
    );
  }
  List<Widget> createList(model) {
    model.listshot = <Widget>[movingCursor(model, model.cursorRed2, Colors.red)];
    return model.listshot;
  }
  Widget movingCursor(MovieBrowserModel model, Cursor cursor, Color color) {
    return Positioned(
      top: cursor.y,
      left: cursor.x,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          model.changePoint(cursor, details.delta.dx, details.delta.dy);
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}

Widget BroserWibView() {
  return WebView(
    initialUrl: 'https://youtube.com',
    javascriptMode: JavascriptMode.unrestricted,
  );
}
