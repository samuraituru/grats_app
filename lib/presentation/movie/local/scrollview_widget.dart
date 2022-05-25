import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/local/countItem_widget.dart';
import 'package:grats_app/presentation/movie/local/movie_local_model.dart';
import 'package:provider/provider.dart';

class ScrollviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieLocalModel>(
      create: (_) => MovieLocalModel(),
      builder: (context, snapshot) {
        return Consumer<MovieLocalModel>(
          builder: (context, model, child) {
            var maps = model.mapGet();
            return Container(
              //height: 380.0,
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.index,
                  //model.inputTextList.length,
                  itemBuilder: (BuildContext context, index) {
                    var passtext = model.countItemList[index];
                    var passindex = index;
                    //var passtext = model.countItem;
                    return CountItemWidget(
                      pullindex: passindex,
                      pulltext: passtext,
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
