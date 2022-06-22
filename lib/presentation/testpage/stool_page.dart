import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/presentation/signup/signup_page.dart';

import '../home/home_page.dart';

class StoolPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
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
              return SignUpPage();
            },
          ),
        );
  }
}
