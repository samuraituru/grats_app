import 'package:objectbox/objectbox.dart';

@Entity() // アノテーションが必要
class objectboxItem {
  objectboxItem({this.itemName, this.itemDescription, this.folderID});

  int id = 0; // id をこのように定義すると自動でインクリメントしてくれる
  String? itemName;
  String? itemDescription;
  int? folderID;
}
