import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:grats_app/presentation/movie/movie_page.dart';
import 'package:grats_app/presentation/testpage/test_model1.dart';
import 'package:provider/provider.dart';

class TestPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<TestModel1>(
        create: (_) => TestModel1(),
        child: Consumer<TestModel1>(builder: (context, model, child) {
          var tabItems = [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: '',
            ),
          ];
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 250,
                        child: Container(
                          child: Material(
                            color: Colors.red,
                            child: InkWell(
                              onTap: () async {},
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MoviePage()),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: model.controller,
                      onChanged: (String? value) {
                        model.actionText1 = value!;
                      },
                      decoration: InputDecoration(
                        hintText: 'カウントしたい項目を追加',
                        suffixIcon: IconButton(
                          onPressed: () {
                            model.actionClearAdd();
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: model.action.length,
                    itemBuilder: (BuildContext context, index) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (value) {},
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: '削除',
                            ),
                          ],
                        ),
                        child: Card(
                          child: ListTile(
                            leading: Container(
                              width: 40,
                              child: FloatingActionButton(
                                heroTag: 'color',
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Pick a color!'),
                                          content: SingleChildScrollView(
                                            child: BlockPicker(
                                              pickerColor: model.mycolor1,
                                              //default color
                                              onColorChanged: (Color color) {
                                                model.colorChanged1(color);
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
                                  child:
                                  Text("Block Color Picker");
                                },
                              ),
                            ),
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
                                    // Text()でもOK
                                    onPressed: () {},
                                  ),
                                ),
                                Text('数'),
                                Container(
                                  width: 40,
                                  child: FloatingActionButton(
                                    heroTag: 'minus',
                                    tooltip: 'Action!',
                                    child: Icon(Icons.remove), // Text()でもOK
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              model.action[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 1,
              onTap: (index) {},
              items: tabItems,
              type: BottomNavigationBarType.fixed,
            ),
          );
        }),
      ),
    );
  }
}
