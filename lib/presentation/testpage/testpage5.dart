import 'package:flutter/material.dart';
import 'package:grats_app/domain/cursor.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/presentation/group/folder/group_folder_page.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:grats_app/presentation/myself/myself_page.dart';
import 'package:grats_app/presentation/testpage/test_model5.dart';
import 'package:provider/provider.dart';

class TestPage5 extends StatelessWidget {
  TestPage5({
    Key? key,
    this.controller,
  }) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<TestModel5>(
        create: (_) => TestModel5(),
        child: Consumer<TestModel5>(
          builder: (context, model, child) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyselfPage()),
                    );
                  },
                ),
              ),
              body: Column(
                children: [
                  _TweetContent(),
                  FloatingActionButton(
                    tooltip: 'Action!',
                    heroTag: 'add',
                    child: Icon(Icons.add),
                    // Text()でもOK
                    onPressed: () {
                      model.createWidget();
                    },
                  ),
                  /*Stack(children: [

                    FloatingActionButton(
                      tooltip: 'Action!',
                      heroTag: 'add',
                      child: Icon(Icons.add),
                      // Text()でもOK
                      onPressed: () {
                        //model.createWidget();
                      },
                    ),
                    //Stack(children: model.counterWidgets,),
                  ]),*/
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void navigateTo(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }
}

class _TweetContent extends StatelessWidget {
  const _TweetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TestModel5>(
      create: (_) => TestModel5(),
      child: Consumer<TestModel5>(builder: (context, model, child) {
        return Stack(
          children: model.bodyList,
        );
      }),
    );
  }
}

class Body extends StatefulWidget {
  final corsor = Cursor(x: 30, y: 100);

  //double x = 0.0;
  //double y = 0.0;
  Cursor? cursorRed1;

  Body({Cursor? cursorRed1, Key? key}) : super(key: key);

  //Cursor? cursorRed1;
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
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
                    widget.corsor.counter++;
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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Cursor? cursorRed1;
  List<Body> bodyList = [];

  //List<Widget> cursorList = [];
  //final moveCorsor = MovingCursor(color: Colors.red);

  @override
  void initState() {
    super.initState();
    cursorRed1 = Cursor(x: 30, y: 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyselfPage()),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Stack(
            children: bodyList,
            //cursorList,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    final bodyWidget = Body(cursorRed1: cursorRed1);
                    bodyList.add(bodyWidget);
                    //cursorList.add(moveCorsor);
                  });
                },
                child: Text('再描画'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    bodyList.removeLast();
                  });
                },
                child: Text('削除'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MovingCursor extends StatelessWidget {
  final cursorRed1 = Cursor(x: 30, y: 100);
  Cursor? cursor;
  Color? color;

  MovingCursor({required Color color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: cursor?.y,
      left: cursor?.x,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          changePoint(cursor!, details.delta.dx, details.delta.dy);
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 30,
          width: 30,
        ),
      ),
    );
  }

  void changePoint(Cursor cursor, double dx, double dy) {
    cursor.x += dx;
    cursor.y += dy;
  }
}
