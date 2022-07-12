import 'package:flutter/material.dart';
import 'package:grats_app/domain/folder.dart';
import 'package:grats_app/domain/objectboxFolder.dart';
import 'package:grats_app/presentation/record/item/record_item_page.dart';
import 'package:grats_app/presentation/slide_right_route.dart';

import '../../main.dart';

class RecordModel extends ChangeNotifier {
  final folderBox = store.box<objectboxFolder>();

  final folderNameController = TextEditingController();
  final folderDescController = TextEditingController();

  void controllerClear() {
    folderNameController.clear();
    folderDescController.clear();
  }

  objectboxFolder? getUser;

  initAction() {}

  void putFolder() {
    if (folderNameController.text == null || folderNameController.text == "") {
      throw 'フォルダー名が入力されていません';
    }
    if (folderDescController.text == null ||
        folderDescController.text.isEmpty) {
      throw '説明が入力されていません';
    }
    final folder = objectboxFolder(
        floderName: folderNameController.text,
        floderDescription: folderDescController.text);
    folderBox.put(folder);
    notifyListeners();
    folderNameController.clear();
    folderDescController.clear();
  }

  void fetchUser() {
    folderBox;
    notifyListeners();
  }

  void getUserName() {
    final int? userId = int.tryParse('${folderNameController.text}');
    final objectboxFolder? getUser = folderBox.get(userId!);
    this.getUser = getUser;
    folderNameController.clear();
  }

  void remove() {
    final int? userId = int.tryParse('${folderNameController.text}');
    folderBox.remove(userId!);
    notifyListeners();
  }
 void foldersBoxRemove(objectboxFolder folder){
    if (folder != null){
      final int? folderID = int.tryParse('${folder.id}');
      folderBox.remove(folderID!);
      notifyListeners();
    }
  }

  void allRemove() {
    folderBox.removeAll();
    notifyListeners();
  }

  void userCount() {
    final userCount = folderBox.count();
    print('${userCount}');
  }

  List<ListTile> fetchBox(context) {
    List<ListTile> folder = folderBox
        .getAll()
        .map(
          (folder) => ListTile(
            onTap: () {
              Navigator.push(context,
                  SlideRightRoute(page: RecordItemPage(folderID: folder.id)));
            },
            leading: Text(folder.floderName ?? '名前無し'),
            title: Text('${folder.floderDescription}'),
          ),
        )
        .toList();
    return folder;
  }
  Future<void> updateFolderName(objectboxFolder folder) async{
    if (folderNameController.value.text == null || folderNameController.value.text == ""){
      throw 'フォルダ名を入力してください';
    }
    if (folderDescController.text == null || folderDescController.text == ""){
      throw '説明を入力してください';
    }

    folder.floderName = folderNameController.text;
    folder.floderDescription = folderDescController.text;

    Future<int> idFuture = folderBox.putAsync(folder);

    final id = await idFuture;
    folderBox.get(id);
    notifyListeners();
  }
}
