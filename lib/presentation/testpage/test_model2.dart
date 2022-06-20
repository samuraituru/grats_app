import 'package:flutter/material.dart';

class TestModel2 extends ChangeNotifier {
  int testInt = 0;
  double x = 0.0;
  double y = 0.0;

  incriment(){
    testInt++;
    notifyListeners();
   var positioned = WidgetSet();
    WidgetList.add(positioned);
  }

  testPanUpdate(DragUpdateDetails details) {
    x += details.delta.dx;
    y += details.delta.dy;
    notifyListeners();
  }
  List<Positioned> WidgetList = [];

  Positioned WidgetSet(){
     Positioned positioned = Positioned(
      top: y,
      left: x,
      child: StatefulBuilder(builder:
          (BuildContext context,
          StateSetter setState) {
        return GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            testPanUpdate(details);
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
                      incriment();
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
                      '{model.moveWidget?.cursor.counter}',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                  ),
                  onPressed: () {
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
     return positioned;
  }
}