import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grats_app/presentation/movie/browser/movie_browser_model.dart';
import 'package:grats_app/presentation/movie/local/local_countItem_widget.dart';
import 'package:grats_app/presentation/movie/movie_page.dart';
import 'package:grats_app/presentation/myself/myself_page.dart';
import 'package:grats_app/presentation/testpage/test_widget7_model.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestMovieBrowserPage extends StatelessWidget {
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<TestWidet7Model>(
        create: (_) => TestWidet7Model()..testInitState(),
        child: Consumer<TestWidet7Model>(builder: (context, model, child) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyselfPage()),
                  );
                },
              ),
              title: Text('Browser'),
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      model.searchIndexList = [];
                    }),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    //webViewController?.reload();
                  },
                ),
              ]
            ),
            body: Stack(children: [
              Stack(
                children: model.testBodyList,
              ),
            ]),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () async {
                await showModalBottomSheet(
                  enableDrag: true,
                  isDismissible: false,
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
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
                                          setState(() {
                                            model.testCountItemCreate();
                                          });
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
                                      itemCount: model.testBodyList.length,
                                      itemBuilder: (BuildContext context, index) {
                                        //final testBody = model.testBodyList[index];
                                        model.moveWidget = model.testBodyList[index];
                                        return StatefulBuilder(builder:
                                            (BuildContext context,
                                            StateSetter setState) {
                                          return Dismissible(
                                            direction: DismissDirection.horizontal,
                                            onDismissed:
                                                (DismissDirection direction) async {
                                              setState(() async {
                                                if (direction ==
                                                    DismissDirection
                                                        .endToStart ||
                                                    direction ==
                                                        DismissDirection
                                                            .startToEnd) {
                                                  //await model.bodyListdelete(index);
                                                }
                                              });
                                            },
                                            key: UniqueKey(),
                                            child: Card(
                                              child: ListTile(
                                                leading: Container(
                                                  width: 40,
                                                  child: FloatingActionButton(
                                                    heroTag: 'color',
                                                    backgroundColor:
                                                    model.moveWidget?.cursor.color,
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                          context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Pick a color!'),
                                                              content:
                                                              SingleChildScrollView(
                                                                child: BlockPicker(
                                                                  pickerColor: model
                                                                      .selectColor,
                                                                  onColorChanged:
                                                                      (Color
                                                                  color) {
                                                                    model.selectColor =
                                                                        color;
                                                                    /*model.changeColor(
                                                                        countItem);*/
                                                                  },
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                ElevatedButton(
                                                                  child: const Text(
                                                                      'DONE'),
                                                                  onPressed: () {
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                      Text("Block Color Picker");
                                                    },
                                                  ),
                                                ),
                                                title: Text('${model.moveWidget?.cursor.title}'),
                                                onLongPress: () {
                                                  print('押された');
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text('項目名を編集'),
                                                        content: TextField(
                                                          controller:
                                                          TextEditingController(
                                                            text: model.moveWidget?.cursor.title,
                                                          ),
                                                          decoration:
                                                          InputDecoration(
                                                            contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                              vertical: 20,
                                                            ),
                                                          ),
                                                          onChanged: (text) {
                                                            model.editTitle = text;
                                                          },
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: Text('キャンセル'),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: Text('更新'),
                                                            onPressed: () {
                                                              /*model.updateText(
                                                                  countItem);*/
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                trailing: StatefulBuilder(builder:
                                                    (BuildContext context,
                                                    StateSetter setState) {
                                                  return Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 40,
                                                        child: FloatingActionButton(
                                                          heroTag: 'plus',
                                                          backgroundColor:
                                                          Colors.pink,
                                                          tooltip: 'Action!',
                                                          child: Icon(Icons.add),
                                                          onPressed: () {
                                                            setState(() {
                                                              model
                                                                  .testIncrement(
                                                                  );

                                                              //model.moveIncrement(model.testBody!.counter);
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Text('${model.moveWidget?.cursor.counter}'),
                                                      Container(
                                                        width: 40,
                                                        child: FloatingActionButton(
                                                          heroTag: 'minus',
                                                          tooltip: 'Action!',
                                                          child: Icon(Icons.remove),
                                                          onPressed: () {
                                                            setState(() {
                                                              /*model
                                                                  .itemCountdecrement(
                                                                  countItem);*/
                                                            });

                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ).whenComplete(() {
                  print('${model.testBodyList[0].cursor.counter}');
                  //model.bodyListAdd();
                  //model.bodyListInsert();
                });
              },
            ),
          );
        }),
      ),
    );
  }
}

class BroserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieBrowserModel>(
      create: (_) => MovieBrowserModel(),
      child: Consumer<MovieBrowserModel>(builder: (context, model, child) {
        return Stack(children: [
          BroserWibView(),
          TweetContent(),
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

class TweetContent extends StatelessWidget {
  const TweetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieBrowserModel>(
      create: (_) => MovieBrowserModel(),
      child: Consumer<MovieBrowserModel>(builder: (context, model, child) {
        return Stack(
          children: model.WidgetList,
        );
      }),
    );
  }
}

class FloatingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieBrowserModel>(
      create: (_) => MovieBrowserModel()..initState(),
      child: Consumer<MovieBrowserModel>(
        builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.arrow_upward),
            onPressed: () async {
              model.WidgetList = await showModalBottomSheet(
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
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
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
                                        setState(() {
                                          //model.testCountItemCreate();
                                        });
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
                      });
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
