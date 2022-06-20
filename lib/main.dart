import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/objectbox.g.dart';
import 'package:grats_app/presentation/introduction/Introduction_model.dart';
import 'package:grats_app/presentation/introduction/introduction_page.dart';
import 'package:grats_app/presentation/testpage/stool_page.dart';
import 'package:provider/provider.dart';


late Store store;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  store = await openStore();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grats App',
      home: ChangeNotifierProvider<IntroductionModel>(
          create: (_) => IntroductionModel(),
          child: Consumer<IntroductionModel>(builder: (context, model, child) {
              return model.firstIntro == true ? IntroductionPage() : StoolPage();
            }
          ),
      ),
    );
  }
}




