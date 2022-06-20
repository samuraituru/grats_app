import 'package:flutter/material.dart';
import 'package:grats_app/domain/objectboxFolder.dart';
import 'package:grats_app/presentation/record/item/record_item_page.dart';

import '../../main.dart';

class RecordModel extends ChangeNotifier {
  final folderBox = store.box<objectboxFolder>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  objectboxFolder? getUser;

  initAction() {}

  void putFolder() {
    if (nameController.text == null || nameController.text == "") {
      throw 'フォルダー名が入力されていません';
    }
    if (descriptionController.text == null ||
        descriptionController.text.isEmpty) {
      throw '説明が入力されていません';
    }
    final folder = objectboxFolder(
        floderName: nameController.text,
        floderDescription: descriptionController.text);
    folderBox.put(folder);
    notifyListeners();
    nameController.clear();
    descriptionController.clear();
  }

  void fetchUser() {
    folderBox;
    notifyListeners();
  }

  void getUserName() {
    final int? userId = int.tryParse('${nameController.text}');
    final objectboxFolder? getUser = folderBox.get(userId!);
    this.getUser = getUser;
    nameController.clear();
  }

  void remove() {
    final int? userId = int.tryParse('${nameController.text}');
    folderBox.remove(userId!);
    notifyListeners();
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordItemPage(
                    folderID: folder.id,
                  ),
                ),
              );
            },
            leading: Text(folder.floderName ?? '名前無し'),
            title: Text('${folder.floderDescription}'),
          ),
        )
        .toList();
    return folder;
  }
}
