import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/group/group_page.dart';
import 'package:grats_app/presentation/home/home_model.dart';
import 'package:grats_app/presentation/movie/movie_page.dart';
import 'package:grats_app/presentation/myself/myself_page.dart';
import 'package:grats_app/presentation/record/record_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(),
      child: Consumer<HomeModel>(builder: (context, model, child) {
        final tabItems = [
          /*TabItem(
              icon: Icon(Icons.home),
              title: 'Home',
            ),*/
          TabItem(
            icon: Icon(Icons.groups_rounded),
            title: 'Group',
          ),
          TabItem(
            icon: Icon(Icons.edit),
            title: 'Record',
          ),
          TabItem(
            icon: Icon(Icons.movie_creation_outlined),
            title: 'Movie',
          ),
          TabItem(
            icon: Icon(Icons.person_rounded),
            title: 'MyPage',
          ),
        ];
        return Scaffold(
          body: _homePageBody(context, model),
          bottomNavigationBar: ConvexAppBar(
            backgroundColor: ThemeColors.color,
            onTap: (index) {
              model.onTabTapped(index);
            },
            initialActiveIndex: model.currentIndex,
            items: tabItems,
            //type: BottomNavigationBarType.fixed,
          ),
        );
      }),
    );
  }

  Widget _homePageBody(BuildContext context, HomeModel model) {
    final currentIndex = model.currentIndex;
    return Stack(
      children: <Widget>[
        /*_tabPage(
          currentIndex,
          0,
          SignUpPage(),
        ),*/
        _tabPage(
          currentIndex,
          0,
          GroupPage(),
        ),
        _tabPage(
          currentIndex,
          1,
          RecordPage(),
        ),
        _tabPage(
          currentIndex,
          2,
          MoviePage(),
        ),
        _tabPage(
          currentIndex,
          3,
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
