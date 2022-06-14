import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/domain/cursor.dart';
import 'package:grats_app/domain/item.dart';
import 'package:grats_app/presentation/movie/browser/movie_browser_model.dart';
import 'package:grats_app/presentation/movie/local/countItem_widget.dart';
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
                !model.searchBoolean ? FloatingView() : null,
          );
        }),
      ),
    );
  }

  /*FloatingView(context) {
    return Consumer<MovieBrowserModel>(
      builder: (context, model, child) {
        return FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: () {
            showModalBottomSheet(
              enableDrag: true,
              isDismissible: false,
              //backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              //trueにしないと、Containerのheightが反映されない
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              builder: (BuildContext context) {
                *//*return Container(
                    height: 540,
                    child: Column(
                      children: [
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
                        Expanded(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: model.countItems.length,
                              itemBuilder: (BuildContext context, index) {
                                final countItem = model.countItems[index];
                                final countItems = model.countItems;
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
                                      '$countItem'
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );*//*
                return SizedBox(
                  height: 400,
                  child: Column(
                    children: [
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
                        height: 335,
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            //physics: NeverScrollableScrollPhysics(),
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
                  ),
                );
              },
            ).whenComplete(() {
              print('showModalBottomSheetが閉じた！');
            });
          },
        );
      },
    );
  }*/
}

class BroserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieBrowserModel>(
      create: (_) => MovieBrowserModel(),
      child: Consumer<MovieBrowserModel>(builder: (context, model, child) {
        return Stack(children: [
          BroserWibView(),
        ]);
      }),
    );
  }
}

Widget BroserWibView() {
  return WebView(
    initialUrl: 'https://youtube.com',
    javascriptMode: JavascriptMode.unrestricted,
  );
}

class FloatingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieBrowserModel>(
      create: (_) => MovieBrowserModel(),
          child: Consumer<MovieBrowserModel>(
            builder: (context, model, child) {
              return FloatingActionButton(
                child: Icon(Icons.arrow_upward),
                onPressed: () {
                  showModalBottomSheet(
                    enableDrag: true,
                    isDismissible: false,
                    //backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    //trueにしないと、Containerのheightが反映されない
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15)),
                    ),
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 400,
                        child: Column(
                          children: [
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
                              height: 335,
                              color: Colors.white,
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                  //physics: NeverScrollableScrollPhysics(),
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
                        ),
                      );
                    },
                  ).whenComplete(() {
                    print('showModalBottomSheetが閉じた！');
                  });
                },
              );
            },
      ),
    );
  }
}
