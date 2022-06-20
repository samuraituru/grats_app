import 'package:flutter/material.dart';
import 'package:grats_app/domain/cursor.dart';
import 'package:grats_app/presentation/movie/browser/movie_browser_model.dart';
import 'package:grats_app/presentation/testpage/test_widget7_model.dart';
import 'package:provider/provider.dart';

class MoveWidget extends StatelessWidget {
  Cursor cursor = Cursor(x: 30, y: 100);

  MoveWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TestWidet7Model>(
      create: (_) => TestWidet7Model()..testInitState(),
      child: Consumer<TestWidet7Model>(
          builder: (context, model, child) {
            return Positioned(
                top: model.moveWidget?.cursor.y,
                left: model.moveWidget?.cursor.x,
                child: StatefulBuilder(builder:
                    (BuildContext context,
                    StateSetter setState) {
                    return GestureDetector(
                      onPanUpdate: (DragUpdateDetails details) {
                        var testBodyList = model.testBodyList;
                        model.testPanUpdate(details);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          //border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                              ),
                              onPressed: () {
                                setState(() {
                                  //counter = model.moveIncrement(counter);
                                  model.testIncrement();
                                });
                              },
                              child: Icon(Icons.add),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              color: Colors.grey,
                              child: Center(
                                child: Text(
                                  '${model.moveWidget?.cursor.counter}',
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                              ),
                              onPressed: () {
                                model.moveDecrement();
                              },
                              child: Icon(Icons.remove),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              );
          }
      ),
    );
  }

  void navigateTo(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }
}
