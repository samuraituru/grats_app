import 'package:flutter/material.dart';

class ScaffoldWrapper extends StatelessWidget {
  ScaffoldWrapper({
    Key? key,
    required this.title,
    required this.child,
    required this.dlgtitle,
    this.wrap = true,
    this.applyword,
  }) : super(key: key);

  final Widget child;
  final String title;
  final String dlgtitle;
  final bool wrap;
  var applyword;

  @override
  Widget build(BuildContext context) {

    if (wrap) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Hero(
            tag: 'app_bar',
            child: AppBar(
              centerTitle: true,
              title: Text(title),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(dlgtitle),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  hintText: " 追加",
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                ),
                                onChanged: (text) {
                                  applyword = text;
                                },
                              ),
                              Padding(padding: EdgeInsets.all(10.0)),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: " 説明",
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 50,
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
                              },
                            ),
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
              elevation: 0.0,
            ),
          ),
        ),
        body: child,
      );
    } else {
      return Material(
        child: child,
      );
    }
  }
}
