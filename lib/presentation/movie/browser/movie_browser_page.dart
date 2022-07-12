import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/movie/browser/movie_browser_model.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieBrowserPage extends StatelessWidget {
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieBrowserModel>(
      create: (_) => MovieBrowserModel()..initState(),
      child: Consumer<MovieBrowserModel>(builder: (context, model, child) {

        List<DropdownMenuItem<String>> folders =
        model.folderList.map((String folder) {
          return DropdownMenuItem(
            child: Text(folder),
            value: folder,
          );
        }).toList();

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: ThemeColors.whiteColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: !model.searchBoolean
                ? Text('Browser')
                : model.searchTextField(),
            actions: !model.searchBoolean
                ? [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      IconButton(
                          icon:
                              Icon(Icons.search, color: ThemeColors.whiteColor),
                          onPressed: () {
                            model.searchPush();
                            model.searchIndexList = [];
                          }),
                      IconButton(
                        icon:
                            Icon(Icons.refresh, color: ThemeColors.whiteColor),
                        onPressed: () {
                          model.webController?.reload();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.output, color: ThemeColors.whiteColor),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context,
                                  StateSetter setState) {
                                return AlertDialog(
                                  title: Text('Recordへ記録しますか？'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        DropdownButton(
                                          items: folders,
                                          onChanged: (String? value) {
                                            setState(() {
                                              model.isSelectedItem = value;
                                            });
                                          },
                                          //7
                                          value:
                                          model.isSelectedItem ?? '選択する',
                                        ),
                                        //Text('$isSelectedItem が選択されました。'),
                                        Column(
                                          children: model.countItems.map((e) {
                                            return Padding(
                                              padding:
                                              const EdgeInsets.all(5.0),
                                              child: Text(
                                                '${e.title}  :  ${e.counter}',
                                                style:
                                                TextStyle(fontSize: 18),
                                              ),
                                            );
                                          }).toList(),
                                        ),

                                        /*for (int i = 0;
                                              i < model.countItems.length;
                                              i++) ...{
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                  '${model.countItems[i].title}  :  ${model.countItems[i].counter}'),
                                            ),

                                            //Text('${model.countItems[i].counter}'),
                                          },*/
                                        //model.outPutText(),
                                        Padding(
                                            padding: EdgeInsets.all(10.0)),
                                      ],
                                    ),
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
                                        try {
                                          model.outPutAction();
                                        } catch (e) {
                                          final snackBar = SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(e.toString()),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } finally {
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                  ],
                                );
                              });
                            },
                          );
                        },
                      ),
                    ]),
                  ]
                : [
                    IconButton(
                      icon: Icon(Icons.youtube_searched_for,
                          color: ThemeColors.whiteColor),
                      onPressed: () {
                        model.searchAction();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.clear, color: ThemeColors.whiteColor),
                      onPressed: () {
                        model.searchPull();
                      },
                    ),
                  ],
          ),
          body: Stack(children: [
            browserWebView(model),
          ]),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_upward),
            onPressed: () async {
              await showModalBottomSheet(
                enableDrag: true,
                isDismissible: true,
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                builder: (BuildContext context) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque, //画面外タップを検知するために必要
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return SizedBox(
                        height: 400,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: model.countItemNameController,
                                onChanged: (String? value) {
                                  model.title = value!;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.comment),
                                  hintText: 'カウントしたい項目を追加',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        try {
                                          model.countItemCreate();
                                        } catch (e) {
                                          final snackBar = SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(e.toString()),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
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
                                    //model.countItem = model.countItems[index];
                                    //final countItems = model.countItems;
                                    //final bodyList = model.bodyList;
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
                                              await model
                                                  .countItemDelete(index);
                                              //await model.countItems.removeAt(index);
                                            }
                                          });
                                        },
                                        key: UniqueKey(),
                                        background: Container(
                                          alignment: Alignment.centerRight,
                                          color: Colors.redAccent[700],
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10.0, 0.0, 20.0, 0.0),
                                              child: Icon(Icons.delete,
                                                  color: Colors.white)),
                                        ),
                                        child: Card(
                                          child: ListTile(
                                            leading: Container(
                                              width: 40,
                                              child: FloatingActionButton(
                                                heroTag: 'color',
                                                backgroundColor:
                                                    countItem.color,
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
                                                                setState(() {
                                                                  model.changeColor(
                                                                      countItem,
                                                                      color);
                                                                });
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
                                            title: Text('${countItem.title}'),
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
                                                        text: countItem.title,
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
                                                          model.updateText(
                                                              countItem);
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
                                                              .itemCountIncrement(
                                                                  countItem);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        '${countItem.counter}'),
                                                  ),
                                                  Container(
                                                    width: 40,
                                                    child: FloatingActionButton(
                                                      heroTag: 'minus',
                                                      tooltip: 'Action!',
                                                      child: Icon(Icons.remove),
                                                      onPressed: () {
                                                        setState(() {
                                                          model
                                                              .itemCountdecrement(
                                                                  countItem);
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
                    }),
                  );
                },
              ).whenComplete(() {
                print('showModalBottomSheetが閉じた！');
              });
            },
          ),
        );
      }),
    );
  }
}

/*class BroserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieBrowserModel>(
      create: (_) => MovieBrowserModel()..initState(),
      child: Consumer<MovieBrowserModel>(builder: (context, model, child) {
        return Stack(children: [
          browserWebView(model),
          TweetContent(),
        ]);
      }),
    );
  }
}*/

Widget browserWebView(model) {
  return WebView(
    initialUrl: 'https://youtube.com',
    javascriptMode: JavascriptMode.unrestricted,
    gestureNavigationEnabled: true,
    onWebViewCreated: (controller) {
      model.webController = controller;
    },
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

/*class FloatingView extends StatelessWidget {
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
                              controller: model.countItemNameController,
                              onChanged: (String? value) {
                                model.title = value!;
                              },
                              decoration: InputDecoration(
                                hintText: 'カウントしたい項目を追加',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      model.countItemCreate();
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
}*/
