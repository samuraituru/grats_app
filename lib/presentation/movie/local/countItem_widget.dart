import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grats_app/domain/item.dart';
import 'package:grats_app/presentation/movie/local/movie_local_model.dart';
import 'package:provider/provider.dart';

class CountItemWidget extends StatelessWidget {
  Item countItem;
  List<Item> countItems;
  int itemIndex;

  CountItemWidget({
    required this.countItem,
    required this.countItems,
    required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieLocalModel>(
      create: (_) => MovieLocalModel(),
      child: Consumer<MovieLocalModel>(
        builder: (context, model, child) {
          return Dismissible(
            direction: DismissDirection.horizontal,
            onDismissed: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart ||
                  direction == DismissDirection.startToEnd) {
                countItems.removeAt(itemIndex);
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
                                        .pop(); //dismiss the color picker
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
                          model.increment(countItem);
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
                          model.decrement(countItem);
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
