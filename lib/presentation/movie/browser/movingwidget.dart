import 'package:flutter/material.dart';
import 'package:grats_app/domain/cursor.dart';
import 'package:grats_app/domain/item.dart';

class MovingWidget extends StatefulWidget {
  Cursor corsor = Cursor(x: 30, y: 100);
  Item? countItem;

  MovingWidget({
    this.countItem,
    Key? key}) : super(key: key);

  @override
  MovingWidgetState createState() => MovingWidgetState();
}

class MovingWidgetState extends State<MovingWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.corsor.y,
      left: widget.corsor.x,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            widget.corsor.x += details.delta.dx;
            widget.corsor.y += details.delta.dy;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
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
                    widget.corsor.counter++;
                  });
                },
                child: Icon(Icons.add),
              ),
              Container(
                height: 50,
                width: 50,
                color: widget.countItem?.color ?? Colors.grey,
                child: Center(
                  child: Text(
                    '${widget.corsor.counter}',
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                ),
                onPressed: () {
                  setState(() {
                    if (widget.corsor.counter > 0) widget.corsor.counter--;
                  });
                },
                child: Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ),
    );
  }
}