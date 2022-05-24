import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/local/movie_local_model.dart';
import 'package:grats_app/presentation/movie/local/watch_widget_model.dart';
import 'package:provider/provider.dart';

class WatchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool moviebool = false;
    return ChangeNotifierProvider<WatchWidgetModel>(
      create: (_) => WatchWidgetModel(),
      child: Consumer<WatchWidgetModel>(builder: (context, model, child) {
        if (model.videoPlayerController == null) {
            return SizedBox(
              width: double.infinity,
              height: 250,
              child: Container(
                child: Material(
                  color: Colors.grey,
                  child: InkWell(
                    onTap: () async {
                      model.openVideoPlayer();
                      print('押された');
                    },
                  ),
                ),
              ),
            );
        } else {
          //初期化後の処理
          return Chewie(
            controller: model.chewieController!,
          );
        }
      }),
    );
  }
}
