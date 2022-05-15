import 'package:flutter/material.dart';

class StickyGroupListViewModel extends ChangeNotifier {
  final double headerDefaultHeight;

  final List<GlobalObjectKey> keys;

  Map<GlobalObjectKey, double> _headerHeightMap = {};

  Map<GlobalObjectKey, double> get headerHeightMap => _headerHeightMap;

  StickyGroupListViewModel(
      {required this.headerDefaultHeight, required this.keys}) {
    _headerHeightMap =
        keys.fold(Map<GlobalObjectKey, double>(), (previousValue, element) {
          previousValue[element] = headerDefaultHeight;
          return previousValue;
        });
  }

  // 指定したkeyのヘッダーの高さを取得する
  double getHeaderHeight(GlobalObjectKey? key) {
    return _headerHeightMap[key] ?? 0;
  }

  // 指定したkeyのヘッダーの高さを更新する
  void setHeaderHeight(GlobalObjectKey key, double height) {
    if (height > headerDefaultHeight) {
      if (getHeaderHeight(key) == headerDefaultHeight) {
        return;
      }
      _headerHeightMap.update(key, (value) => headerDefaultHeight);
    } else if (height < 0) {
      if (getHeaderHeight(key) == 0) {
        return;
      }
      _headerHeightMap.update(key, (value) => 0);
    } else {
      if (getHeaderHeight(key) == height) {
        return;
      }
      _headerHeightMap.update(key, (value) => height);
    }
    notifyListeners();
  }
}
class TestModel1 extends ChangeNotifier {
  var controller = TextEditingController();
  var editText = '';
  var fruits = <String>['例)反則数'];

  void clearAdd() {
    this.fruits.add(editText);
    this.controller.clear();
    notifyListeners();
  }
}
