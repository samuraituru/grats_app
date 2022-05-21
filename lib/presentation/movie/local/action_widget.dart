import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grats_app/presentation/movie/local/action_widget_model.dart';
import 'package:provider/provider.dart';

class ActionWidget extends StatelessWidget {
  int pullindex = 0;
  List pulllist = [];

  ActionWidget({required this.pullindex,required this.pulllist});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActionWidgetModel>(
      create: (_) => ActionWidgetModel(),
      child: Consumer<ActionWidgetModel>(
        builder: (context, model, child) {
          return Dismissible(
            direction: DismissDirection.horizontal,
            onDismissed: (DismissDirection direction) async {
              await pulllist.removeAt(pullindex);
            },
            key: UniqueKey(),
            child: Card(
              child: ListTile(
                leading: Container(
                  width: 40,
                  child: FloatingActionButton(
                    heroTag: 'color',
                    backgroundColor: model.selectcolor,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: BlockPicker(
                                  pickerColor: model.selectcolor,
                                  onColorChanged: (Color color) {
                                    model.colorChanged(color);
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
                  model.completetextlist != null
                      ? '${pulllist[pullindex]}'
                      : '${model.completetextlist[pullindex]}',
                ),
                onLongPress: () {
                  print('押された');
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('項目名を編集'),
                          content: TextField(
                            controller: TextEditingController(
                              text: pulllist[pullindex],
                            ), //初期値
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                            ),
                            onChanged: (text) {
                              pulllist[pullindex] = text;
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
                                pulllist = model.completetextlist;
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
                        },
                      ),
                    ),
                    Text('${model.counter}'),
                    Container(
                      width: 40,
                      child: FloatingActionButton(
                        heroTag: 'minus',
                        tooltip: 'Action!',
                        child: Icon(Icons.remove),
                        onPressed: () {
                          model.decrement();
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
