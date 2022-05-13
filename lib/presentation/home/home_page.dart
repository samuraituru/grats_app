import 'package:flutter/material.dart';
import 'package:grats_app/presentation/group/group_page.dart';
import 'package:grats_app/presentation/home/home_model.dart';
import 'package:grats_app/presentation/movie/movie_page.dart';
import 'package:grats_app/presentation/myself/myself_page.dart';
import 'package:grats_app/presentation/record/record_page.dart';
import 'package:grats_app/presentation/signup/signup_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pageList = [
      SignPage(),
      GroupPage(),
      GroupPage(),
      //RecordPage(),
      MoviePage(),
      MyselfPage(),
    ];

    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;


    return MaterialApp(
      home: ChangeNotifierProvider<HomeModel>(
        create: (_) => HomeModel(),
        child: Consumer<HomeModel>(builder: (context, model, child) {
          final tabItems = [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.groups_rounded),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation_outlined),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: '',
            ),
          ];
          return Scaffold(
            body: _pageList[model.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: model.currentIndex,
              onTap: (index) {
                model.currentIndex = index;
              },
              items: tabItems,
              type: BottomNavigationBarType.fixed,
            ),
          );
        }),
      ),
    );
  }
}