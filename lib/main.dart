import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/objectbox.g.dart';
import 'package:grats_app/presentation/group/group_page.dart';
import 'package:grats_app/presentation/home/home_page.dart';
import 'package:grats_app/presentation/introduction/Introduction_model.dart';
import 'package:grats_app/presentation/introduction/introduction_page.dart';
import 'package:grats_app/presentation/login/login_page.dart';
import 'package:grats_app/presentation/movie/movie_page.dart';
import 'package:grats_app/presentation/myself/myself_setting_page.dart';
import 'package:grats_app/presentation/myself/myself_page.dart';
import 'package:grats_app/presentation/record/record_page.dart';
import 'package:grats_app/presentation/signup/signup_page.dart';
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
      theme: createTheme(),
      routes: <String, WidgetBuilder>{
        '/group': (BuildContext context) => GroupPage(),
        '/home': (BuildContext context) => HomePage(),
        '/introduction': (BuildContext context) => IntroductionPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/movie': (BuildContext context) => MoviePage(),
        '/myself': (BuildContext context) => MyselfPage(),
        '/record': (BuildContext context) => RecordPage(),
        '/signUp': (BuildContext context) => SignUpPage(),
        '/myself/setting': (BuildContext context) => MyselfSetting(),

      },
      debugShowCheckedModeBanner: false,
      title: 'Grats App',
      home: LoginCheckPage(),
    );
  }
}



class LoginCheckPage extends StatelessWidget {
  const LoginCheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IntroductionModel>(
      create: (_) => IntroductionModel(),
      child: Consumer<IntroductionModel>(builder: (context, model, child) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // スプラッシュ画面などに書き換えても良い
              return const SizedBox();
            }
            if (snapshot.hasData) {
              // User が null でなない、つまりサインイン済みのホーム画面へ
              return HomePage();
            }
            // User が null である、つまり未サインインのサインイン画面へ
            return StoolPage();
          },
        );

        //return model.firstIntro == true ? IntroductionPage() : StoolPage();
      }),
    );
  }
}

class ThemeColors {
  static const color = const Color(0xFF00E676);
  static const accentColor = const Color(0xFFFFAB91);
  static const cyanSubColor = const Color(0xFFB2EBF2);
  static const cyanColor = const Color(0xFF80DEEA);
  static const buttonColor = const Color(0xFFEEEEEE);
  static const whiteColor = const Color(0xFFFFFFFF);
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
  static Map<int, Color> cyanColorPallet = {
    50: Color(0xFFE0F7FA),
    100: Color(0xFFB2EBF2),
    200: Color(0xFF80DEEA),
    300: Color(0xFF4DD0E1),
    400: Color(0xFF26C6DA),
    500: Color(0xFF26C6DA),
    600: Color(0xFF00ACC1),
    700: Color(0xFF00ACC1),
    800: Color(0xFF00ACC1),
    900: Color(0xFF006064),
    1100: Color(0xFF84FFFF),
    1200: Color(0xFF18FFFF),
    1400: Color(0xFF00E5FF),
    1700: Color(0xFF00B8D4),
  };
}

ThemeData createTheme() {
  final MaterialColor primeColor =
      MaterialColor(0xFF00E676, ThemeColors.baseColorPallet);

  return ThemeData(
    primarySwatch: primeColor,
    primaryColor: ThemeColors.cyanSubColor,
    //fontFamily: 'Shadows_Into_Light',
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'Courgette',
        fontSize: 27,
      ),
    ),
  );
}

class AppBackground extends StatelessWidget {
  AppBackground({height, width});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraint) {
      final height = contraint.maxHeight;
      final width = contraint.maxWidth;
      return Container();
    });
  }
}
