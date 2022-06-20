import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grats_app/domain/item.dart';
import 'package:grats_app/presentation/movie/browser/movie_browser_model.dart';
import 'package:grats_app/presentation/movie/browser/movingwidget.dart';
import 'package:provider/provider.dart';

class TestWidget6 extends StatelessWidget {
  Item countItem;
  List<Item> countItems;
  int itemIndex;
  List<MovingWidget> bodyList;

  TestWidget6({
    required this.countItem,
    required this.countItems,
    required this.itemIndex,
    required this.bodyList,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieBrowserModel>(
      create: (_) => MovieBrowserModel(),
      child: Consumer<MovieBrowserModel>(
        builder: (context, model, child) {
          return Dismissible(
            direction: DismissDirection.horizontal,
            onDismissed: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart ||
                  direction == DismissDirection.startToEnd) {
                await countItems.removeAt(itemIndex);
                await bodyList.removeAt(itemIndex);
                //await model.countItemdelete();
              }
            },
            key: UniqueKey(),
            child: Card(
              child: ListTile(
                leading: Container(
                  width: 40,
                  child: FloatingActionButton(
                    heroTag: 'color',
                    backgroundColor: countItem.color,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: BlockPicker(
                                  pickerColor: model.selectColor,
                                  onColorChanged: (Color color) {
                                    model.selectColor = color;
                                    model.changeColor(countItem);
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
                title: Text('${countItem.title}'),
                /*model.completetextlist == null
                      ? '${model.countItemList[model.countItemList.length]}'
                      : '${model.completetextlist[pullindex]}',*/
                onLongPress: () {
                  print('押された');
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('項目名を編集'),
                        content: TextField(
                          controller: TextEditingController(
                            text: countItem.title,
                          ), //初期値
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
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
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Text('更新'),
                            onPressed: () {
                              model.updateText(countItem);
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
                          model.itemCountIncrement(countItem);
                        },
                      ),
                    ),
                    Text('${countItem.counter}'),
                    //'${model.counterList[pullindex]}'),
                    Container(
                      width: 40,
                      child: FloatingActionButton(
                        heroTag: 'minus',
                        tooltip: 'Action!',
                        child: Icon(Icons.remove),
                        onPressed: () {
                          //model.decrement(countItem);
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
    );
  }
}
