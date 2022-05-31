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
            body: _homePageBody(context, model),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                model.onTabTapped(index);
              },
              currentIndex: model.currentIndex,
              items: tabItems,
              type: BottomNavigationBarType.fixed,
            ),
          );
        }),
      ),
    );
  }

  Widget _homePageBody(BuildContext context, HomeModel model) {
    final currentIndex = model.currentIndex;
    return Stack(
      children: <Widget>[
        _tabPage(
          currentIndex,
          0,
          SignUpPage(),
        ),
        _tabPage(
          currentIndex,
          1,
          GroupPage(),
        ),
        _tabPage(
          currentIndex,
          2,
          RecordPage(),
        ),
        _tabPage(
          currentIndex,
          3,
          MoviePage(),
        ),
        _tabPage(
          currentIndex,
          4,
          MyselfPage(),
        ),
      ],
    );
  }

  Widget _tabPage(int currentIndex, int tabIndex, StatelessWidget page) {
    return Visibility(
      visible: currentIndex == tabIndex,
      maintainState: true,
      child: page,
    );
  }
}
