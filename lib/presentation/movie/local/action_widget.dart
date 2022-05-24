import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grats_app/presentation/movie/local/movie_local_model.dart';
import 'package:provider/provider.dart';

class CountItemWidget extends StatelessWidget {
  int pullindex = 0;
  String pulltext = '';

  CountItemWidget({required this.pullindex, required this.pulltext});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieLocalModel>(
      create: (_) => MovieLocalModel(),
      child: Consumer<MovieLocalModel>(
        builder: (context, model, child) {
          return Dismissible(
            direction: DismissDirection.horizontal,
            onDismissed: (DismissDirection direction) async {
              if (direction == DismissDirection.horizontal) {
                //await pulllist.removeAt(pullindex);

                model.colorReset();
              }
            },
            key: UniqueKey(),
            child: Card(
              child: ListTile(
                leading: Container(
                  width: 40,
                  child: FloatingActionButton(
                    heroTag: 'color',
                    backgroundColor: model.selectColor,
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
                                    model.changeColor(color);
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
                title: Text(
                      '${pulltext}'
                  /*model.completetextlist == null
                      ? '${model.countItemList[model.countItemList.length]}'
                      : '${model.completetextlist[pullindex]}',*/
                ),
                onLongPress: () {
                  model.CollText();
                  print('押された');
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('項目名を編集'),
                          content: TextField(
                            controller: TextEditingController(
                              text: pulltext,//pulllist[pullindex],
                            ), //初期値
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                            ),
                            onChanged: (text) {
                              pulltext = text;
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
                                //model.updateText();
                                //pulltext = model.completetext;
                                model.updateList();
                                pulltext = model.completetext;
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
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
                          model.increment();
                          model.incrementList();
                        },
                      ),
                    ),
                    Text(
                        '${model.counter}'),
                        //'${model.counterList[pullindex]}'),
                    Container(
                      width: 40,
                      child: FloatingActionButton(
                        heroTag: 'minus',
                        tooltip: 'Action!',
                        child: Icon(Icons.remove),
                        onPressed: () {
                          model.decrement();
                          model.decrementList();
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
