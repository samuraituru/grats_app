import 'package:flutter/material.dart';
import 'package:grats_app/presentation/signup/sign_model.dart';
import 'package:provider/provider.dart';

class SignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<SignModel>(
        create: (_) => SignModel(),
        child: Consumer<SignModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('新規登録'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'メールアドレス',
                  labelText: 'メールアドレス',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
