import 'package:flutter/material.dart';
import 'package:grats_app/domain/countitem.dart';
import 'package:grats_app/domain/item.dart';
import 'package:grats_app/domain/objectboxFolder.dart';
import 'package:grats_app/domain/objectboxitem.dart';
import 'package:grats_app/main.dart';

class MovieLocalModel extends ChangeNotifier {
  final texteditingcontroller = TextEditingController();
  final scrollController = ScrollController();
  String editTitle = '';
  int counter = 0;
  Color selectColor = Colors.lightBlue;
  final folderBox = store.box<objectboxFolder>();
  final itemBox = store.box<objectboxItem>();
  String? isSelectedItem = '選択する';
  List<String> folderList = ['選択する'];
  List<String> dropItem = [];

  var countItems = <Item>[];

  void countItemCreate() {
    if (texteditingcontroller.text != null) {
      countItems.add(Item(title: texteditingcontroller.text));
      this.texteditingcontroller.clear();
      notifyListeners();
      texteditingcontroller.clear();
    }
  }
  Map<int ,String> dropMaps = {};
int? boxIDs;
  void initState() {
    List<DropdownMenuItem<String>> folder = folderBox.getAll().map(
      (box) {
        folderList.add(box.floderName!);
        dropMaps[box.id] = '${box.floderName}';
        //print(model.folderList);
        return DropdownMenuItem(
          child: Text('${box.floderName}'),
          value: '${box.floderName}',
        );
      },
    ).toList();
  }
  void putItem(String title,String counter){
    final item = objectboxItem(
        itemName: title,
        itemDescription: counter,
        /*folderID: folderID*/);
    itemBox.put(item);
  }

  void increment(Item countItem) {
    countItem.counter += 1;
    notifyListeners();
  }

  void decrement(Item countItem) {
    if (countItem.counter > 0) countItem.counter -= 1;
    notifyListeners();
  }

  void changeColor(Item countItem) {
    countItem.color = selectColor;
    notifyListeners();
  }

  void updateText(Item countItem) {
    countItem.title = editTitle;
  }

  void colorPicker() {
    pickerColor:
    Colors.red; //default color
    onColorChanged:
    (Color color) {
      //on color picked
      print(color);
    };
  }

/*  Widget outPutText() {
    if (!countItems.isEmpty) {
      {
        for (var i = 0; i < countItems.length; i++)
        return Text(
            '${countItems[0]}\n${counter}');
      }
    } else {
      return const Text('項目なし');
    }
  }*/

/*Future listOutput() async {
    for (int i = 0; i < countItemList.length; i++) {
      countMap = {
        '${countItemList[i]}': '${counterList[i]}',
      };
    }
    notifyListeners();
  }*/
}

DropdownMenuItem DropItem(int key, String value) {
  void intGet(){
    int i = 0;
  }
  return DropdownMenuItem(
    child: Text('$value'),
    value: '${value}',
  );

}
