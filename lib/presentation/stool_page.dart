import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/presentation/introduction/Introduction_model.dart';
import 'package:grats_app/presentation/introduction/introduction_page.dart';
import 'package:grats_app/presentation/signup/signup_page.dart';
import 'package:provider/provider.dart';

class StoolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IntroductionModel>(
      create: (_) => IntroductionModel()..getPrefIntro(),
      child: Consumer<IntroductionModel>(
        builder: (context, model, child) {
          //trueであればIntroductionPageを表示し
          //falseであればSignUpPageを表示する
          return model.firstIntro == true ? IntroductionPage() : SignUpPage();
        },
      ),
    );
  }
}
