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
        }),
      ),
    );
  }
}

class ThemeColors {

  static const color = const Color(0xFF00E676);
  static const accentColor = const Color(0xFFFFAB91);
  static const subColor = const Color(0xFFC5CAE9);
  static const buttonColor = const Color(0xFFEEEEEE);
  static const textColor = const Color(0xFFFFFFFF);
  static const backGroundColor = const Color(0xFFEEEEEE);
  static Map<int, Color> baseColorPallet = {
    50: Color(0xFFE8F5E9),
    100: Color(0xFFC8E6C9),
    200: Color(0xFFA5D6A7),
    300: Color(0xFF81C784),
    400: Color(0xFF66BB6A),
    500: Color(0xFF4CAF50),
    600: Color(0xFF43A047),
    700: Color(0xFF388E3C),
    800: Color(0xFF2E7D32),
    900: Color(0xFF1B5E20),
  };
  static Map<int, Color> subColorPallet = {
    50: Color(0xFFedf7f8),
    100: Color(0xFFd1eaee),
    200: Color(0xFFb2dde3),
    300: Color(0xFF93cfd8),
    400: Color(0xFF7cc4cf),
    500: Color(0xFF65bac7),
    600: Color(0xFF5db3c1),
    700: Color(0xFF53abba),
    800: Color(0xFF49a3b3),
    900: Color(0xFF3794a6),
  };
}

ThemeData createTheme() {
  final MaterialColor primeColor = MaterialColor(0xFF00E676, ThemeColors.baseColorPallet);


  return ThemeData(
    primarySwatch: primeColor,
      primaryColor: ThemeColors.subColor,
  );
}


class AppBackground extends StatelessWidget {

  AppBackground({height,width});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraint) {
      final height = contraint.maxHeight;
      final width = contraint.maxWidth;
      return Container();
    });
  }
}