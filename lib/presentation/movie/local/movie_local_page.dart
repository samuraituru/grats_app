import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/movie/local/local_countItem_widget.dart';
import 'package:grats_app/presentation/movie/local/movie_local_model.dart';
import 'package:grats_app/presentation/movie/local/watch_widget.dart';
import 'package:provider/provider.dart';

class MovieLocalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieLocalModel>(
      create: (_) => MovieLocalModel()..initState(),
      child: Consumer<MovieLocalModel>(
        builder: (context, model, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: LayoutBuilder(
              builder: (context, constraints) {
                return constraints.maxWidth < constraints.maxHeight
                    ? _buildHorizontal(context)
                    : _buildHorizontal(context);
              },
            ),
          );
        },
      ),
    );
  }

  // 縦向きの場合
  Widget _buildHorizontal(BuildContext context) {
    return Consumer<MovieLocalModel>(builder: (context, model, child) {
      List<String> folderList = [];

      List<DropdownMenuItem<String>> folders =
          model.folderList.map((String folder) {
        return DropdownMenuItem(
          child: Text(folder),
          value: folder,
        );
      }).toList();
      return GestureDetector(
        behavior: HitTestBehavior.opaque, //画面外タップを検知するために必要
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: WatchWidget(),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: ThemeColors.whiteColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.output,
                            color: ThemeColors.whiteColor,
                          ),
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
                                          TextField(
                                            controller: model.itemNameController,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.folder_open),
                                              labelText: 'アイテム名を記載',
                                              //fillColor: ThemeColors.backGroundColor,
                                              filled: true,
                                              contentPadding: EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  //color: ThemeColors.whiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: model.countItems.map((countItem) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  '${countItem.title}  :  ${countItem.counter}',
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: model.countItemNameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.comment),
                  hintText: 'カウントしたい項目を追加',
                  suffixIcon: IconButton(
                    onPressed: () {
                      try {
                        model.countItemCreate();
                      } catch (e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
            ),
            Container(
              height: 400,
              child: SingleChildScrollView(
                controller: model.scrollController,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
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
  }

  Widget _buildVertical(BuildContext context) {
    return Consumer<MovieLocalModel>(builder: (context, model, child) {
      return Container(
        alignment: Alignment.center,
        color: Colors.pink,
        child: Text("ヨコ", style: TextStyle(fontSize: 32)),
      );
    });
  }
}
