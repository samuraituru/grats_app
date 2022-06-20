import 'package:objectbox/objectbox.dart';

@Entity() // アノテーションが必要
class objectboxFolder {
  objectboxFolder({this.floderName,this.floderDescription});
  int id = 0; // id をこのように定義すると自動でインクリメントしてくれる
  String? floderName;
  String? floderDescription;
}
