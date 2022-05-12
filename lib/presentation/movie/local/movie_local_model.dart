import 'package:flutter/material.dart';

class Task {
  Task(this.tasks);
  String tasks;
}
class MovieLocalModel extends ChangeNotifier {
  List<Task>? tasks;
  String? task;

  Future addbook() async {
    if (task == null || task == "") {
      throw 'タイトルが入力されていません';
    }
    notifyListeners();
  }
  void fetchBookList() async {
    this.tasks = tasks;
    notifyListeners();
  }
}