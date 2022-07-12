import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/item2.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/group/item/group_item_model.dart';
import 'package:provider/provider.dart';

class GroupItemPage extends StatelessWidget {
  Folder folder;

  GroupItemPage({required this.folder});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupItemModel>(
      create: (_) => GroupItemModel()..getItem(folder),
      child: Consumer<GroupItemModel>(
        builder: (context, model, child) {
          final List<Item2>? items = model.items;

          if (items == null) {
            return const SizedBox(
                width: 100,
                height: 100,
                child: Center(child: CircularProgressIndicator()));
          }

          return Scaffold(
            /*appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: ThemeColors.whiteColor),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text('Item'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add, color: ThemeColors.whiteColor),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('アイテムを追加'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: model.itemNameController,
                                //textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.folder_open),
                                  labelText: 'アイテム名を記載',
                                  //fillColor: ThemeColors.backGroundColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        //color: ThemeColors.whiteColor,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10.0)),
                              TextField(
                                controller: model.itemDescController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.folder_open),
                                  labelText: '説明を記載',
                                  //fillColor: ThemeColors.backGroundColor,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 40,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        //color: ThemeColors.whiteColor,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('キャンセル'),
                              onPressed: () {
                                Navigator.pop(context);
                                model.controllerClear();
                              },
                            ),
                            TextButton(
                              child: Text('OK'),
                              onPressed: () async {
                                try {
                                  await model.setItem(folder);
                                } catch (e) {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(e.toString()),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } finally {
                                  await model.getItem(folder);
                                  Navigator.pop(context);
                                  model.controllerClear();
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),*/
            body: RefreshIndicator(
                onRefresh: () async {
                  await model.getItem(folder);
                },
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                            color: ThemeColors.whiteColor),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      floating: true,
                      pinned: true,
                      snap: true,
                      expandedHeight: 250.0,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: GestureDetector(
                          onTap: () => print('tap'),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'lib/assets/images/forest_image.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        title: Text('Item',
                            style: TextStyle(
                                color: ThemeColors.whiteColor,
                                fontFamily: 'Courgette',
                                fontSize: 27)),
                      ),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.add, color: ThemeColors.whiteColor),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('アイテムを追加'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: model.itemNameController,
                                        //textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.folder_open),
                                          labelText: 'アイテム名を記載',
                                          //fillColor: ThemeColors.backGroundColor,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                //color: ThemeColors.whiteColor,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.all(10.0)),
                                      TextField(
                                        controller: model.itemDescController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.folder_open),
                                          labelText: '説明を記載',
                                          //fillColor: ThemeColors.backGroundColor,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 40,
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
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('キャンセル'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        model.controllerClear();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () async {
                                        try {
                                          await model.setItem(folder);
                                        } catch (e) {
                                          final snackBar = SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(e.toString()),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } finally {
                                          await model.getItem(folder);
                                          Navigator.pop(context);
                                          model.controllerClear();
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                    SliverFixedExtentList(
                      itemExtent: 200.0,
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final widgets = ListTile(
                            onTap: () {},
                            trailing: IconButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      content: Text('フォルダを削除しますか？'),
                                      actions: <Widget>[
                                        SimpleDialogOption(
                                          child: Text('Yes'),
                                          onPressed: () async{
                                            await model.itemDocDelete(index);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        SimpleDialogOption(
                                          child: Text('No'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                  model.getItem(folder);
                                },
                                icon: Icon(Icons.delete_forever)),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('名前'),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                ),
                                Container(
                                  width: 200,
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Text(
                                      '${model.items![index].itemName}',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('備考'),
                                Padding(
                                  padding: EdgeInsets.all(6.0),
                                ),
                                Container(
                                  width: 200,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      model.items![index].itemDescription!,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                          final List<Widget> test = items
                              .map(
                                (item) => ListTile(
                                  trailing: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.delete_forever)),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('名前'),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                      ),
                                      Container(
                                        width: 200,
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Text(
                                            '${model.items![index].itemName}',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('備考'),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                      ),
                                      Container(
                                        width: 200,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            model
                                                .items![index].itemDescription!,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList();
                          return widgets;

                          /*Container(
                            alignment: Alignment.center,
                            color: Colors.lightBlue[100 * (index % 9)],
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('名前'),
                                    Padding(padding: EdgeInsets.all(8.0),),
                                    Container(
                                      width: 200,
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Text(
                                          '${model.items![index].itemName}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    IconButton(onPressed: (){

                                    }, icon: Icon(Icons.delete_forever))
                                  ],
                                ),
                                Padding(padding: EdgeInsets.all(6.0),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('備考'),
                                    Padding(padding: EdgeInsets.all(6.0),),
                                    Container(
                                      width: 200,
                                      height:120,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          model.items![index].itemDescription!,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );*/
                        },
                        childCount: model.items?.length,
                      ),
                    ),
                  ],
                )

                /*CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                            color: ThemeColors.whiteColor),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      pinned: true,
                      expandedHeight: 250.0,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: GestureDetector(
                          onTap: () => print('tap'),
                          child: Container(
                            height: 250.0,
                            child: Image.asset(
                              'lib/assets/images/forest.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text('Item',
                            style: TextStyle(
                                color: ThemeColors.whiteColor,
                                fontFamily: 'Courgette',
                                fontSize: 27)),
                      ),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.add, color: ThemeColors.whiteColor),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('アイテムを追加'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: model.itemNameController,
                                        //textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.folder_open),
                                          labelText: 'アイテム名を記載',
                                          //fillColor: ThemeColors.backGroundColor,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                //color: ThemeColors.whiteColor,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.all(10.0)),
                                      TextField(
                                        controller: model.itemDescController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.folder_open),
                                          labelText: '説明を記載',
                                          //fillColor: ThemeColors.backGroundColor,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 40,
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
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('キャンセル'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        model.controllerClear();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () async {
                                        try {
                                          await model.setItem(folder);
                                        } catch (e) {
                                          final snackBar = SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(e.toString()),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } finally {
                                          await model.getItem(folder);
                                          Navigator.pop(context);
                                          model.controllerClear();
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                    SliverList(
                      key: centerKey,
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Container(
                            alignment: Alignment.center,
                            color: Colors.lightBlue[100 * (index % 9)],*/ /*
                            child: ListView(
                              children: widgets,
                            ),*/ /*
                          );
                        },
                        //childCount: model.items?.length,
                      ),
                    ),
                  ],
                )*/

                /*CustomScrollView(
                slivers: [
                  SliverStickyHeader.builder(
                    builder: (context, state) => Container(
                      height: 60.0,
                      color: (state.isPinned
                              ? ThemeColors.cyanColor
                              : Colors.lightBlue)
                          .withOpacity(1.0 - state.scrollPercentage),
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Item',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ListTile(
                          title: Text(model.items![index].itemName),
                          subtitle:
                              Text('${model.items![index].itemDescription}'),
                        ),
                        childCount: model.items?.length,
                      ),
                    ),
                  ),
                ],
              ),*/
                ),
          );
        },
      ),
    );
  }
}
