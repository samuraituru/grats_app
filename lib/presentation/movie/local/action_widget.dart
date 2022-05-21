import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/local/action_widget_model.dart';
import 'package:provider/provider.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActionWidgetModel>(
      create: (_) => ActionWidgetModel(),
      child: Consumer<ActionWidgetModel>(
        builder: (context, model, child) {
          return ListTile(
            title: Text('${model.counter}'),
            trailing: IconButton(
              onPressed: () {
                model.increment();
                print('onpress');
              },
              icon: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
