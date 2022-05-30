import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/local/countItem_widget.dart';
import 'package:grats_app/presentation/movie/local/movie_local_model.dart';
import 'package:provider/provider.dart';

class ScrollviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieLocalModel>(
        create: (_) => MovieLocalModel(),
        child: Consumer<MovieLocalModel>(
          builder: (context, model, child) {
            return Container(
              //height: 380.0,
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.countItems.length,
                  itemBuilder: (BuildContext context, index) {
                    final countItem = model.countItems[index];
                    return CountItemWidget(countItem: countItem);
                  },
                ),
              ),
            );
          },
        ),
    );
  }
}
