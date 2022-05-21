import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/local/action_widget.dart';

class TestListview extends StatelessWidget {
  const TestListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (index, context) {
        return ActionWidget();
      },
      itemCount: 3,
    );
  }
}
