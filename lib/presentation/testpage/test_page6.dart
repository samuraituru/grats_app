import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grats_app/domain/item.dart';
import 'package:grats_app/presentation/movie/browser/movingwidget.dart';
import 'package:grats_app/presentation/movie/movie_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestPage6 extends StatefulWidget {
  TestPage6({Key? key}) : super(key: key);

  @override
  State<TestPage6> createState() => _TestPage6State();
}

class _TestPage6State extends State<TestPage6> {
  List<MovingWidget> bodyList = [];
  List<Item> countItems = [];
  final texteditingcontroller = TextEditingController();
  final scrollController = ScrollController();
  String editTitle = '';
  Color selectColor = Colors.lightBlue;
  String title = '';
  Item? countItem;

  @override
  void initState() {
    super.initState();
  }
  void create() {
    setState(() {
      if (title != null) {
        countItems.add(Item(title: title));
        texteditingcontroller.clear();

        final bodyWidget =
        MovingWidget(countItem: countItem);
        bodyList.add(bodyWidget);
      }
    });
  }


  void delete(direction,index) {
    setState(() {
      if (direction == DismissDirection.endToStart ||
          direction == DismissDirection.startToEnd) {
          countItems.removeAt(index);
          bodyList.removeAt(index);
      }
    });
  }

  void incrementCounter() {
    setState(() {
      countItem?.counter += 1;
    });
  }

  void decrementCounter() {
    setState(() {
      if (countItem!.counter > 0) countItem?.counter -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Stack(children: [
        WebView(
          initialUrl: 'https://youtube.com',
          javascriptMode: JavascriptMode.unrestricted,
        ),
        Stack(
          children: bodyList,
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () async {
          await showModalBottomSheet(
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
                          controller: texteditingcontroller,
                          onChanged: (String? value) {
                            title = value!;
                          },
                          decoration: InputDecoration(
                            hintText: 'カウントしたい項目を追加',
                            suffixIcon: IconButton(
                              onPressed: () {
                                create();
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
                            shrinkWrap: true,
                            itemCount: countItems.length,
                            itemBuilder: (BuildContext context, index) {
                              final listItem = countItems[index];
                              return Dismissible(
                                direction: DismissDirection.horizontal,
                                onDismissed:
                                    (DismissDirection direction) {
                                  delete(direction,index);
                                    },
                                key: UniqueKey(),
                                child: Card(
                                  child: ListTile(
                                    leading: Container(
                                      width: 40,
                                      child: FloatingActionButton(
                                        heroTag: 'color',
                                        backgroundColor: listItem.color,
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Pick a color!'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: BlockPicker(
                                                      pickerColor: selectColor,
                                                      onColorChanged:
                                                          (Color color) {
                                                        setState(() {
                                                          selectColor = color;
                                                          listItem.color =
                                                              selectColor;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      child: const Text('DONE'),
                                                      onPressed: () {
                                                        Navigator.of(context)
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
                                    title: Text('${listItem.title}'),
                                    onLongPress: () {
                                      print('押された');
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('項目名を編集'),
                                            content: TextField(
                                              controller: TextEditingController(
                                                text: listItem.title,
                                              ), //初期値
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  vertical: 20,
                                                ),
                                              ),
                                              onChanged: (text) {
                                                editTitle = text;
                                              },
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('キャンセル'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text('更新'),
                                                onPressed: () {
                                                  listItem.title = editTitle;
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          width: 40,
                                          child: FloatingActionButton(
                                            heroTag: 'plus',
                                            backgroundColor: Colors.pink,
                                            tooltip: 'Action!',
                                            child: Icon(Icons.add),
                                            onPressed: () {
                                              incrementCounter();
                                            },
                                          ),
                                        ),
                                        Text('${listItem.counter}'),
                                        //'${model.counterList[pullindex]}'),
                                        Container(
                                          width: 40,
                                          child: FloatingActionButton(
                                            heroTag: 'minus',
                                            tooltip: 'Action!',
                                            child: Icon(Icons.remove),
                                            onPressed: () {
                                              decrementCounter();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
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
      ),
    );
  }
}
