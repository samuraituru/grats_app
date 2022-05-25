import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:grats_app/presentation/movie/local/watch_widget_model.dart';
import 'package:provider/provider.dart';

class WatchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    //model.openVideoPlayer();
                    print('押された');
                  },
                ),
              ),
            ),
          );
        }
        return Center(
           child: model.videoPlayerController!.value.isInitialized
            //動画再生表示画面の比率をオリジナルのまま表示してくれる
                ? AspectRatio(
                  aspectRatio:  model.videoPlayerController!.value.aspectRatio,
                   //数行で動画再生してくれる。
                child: Chewie(
                controller: model.chewieController!,
              ),
            )
                :
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Container(
                child: Material(
                  color: Colors.grey,
                  child: InkWell(
                    onTap: () async {
                      model.openVideoPlayer();
                      //model.openVideoPlayer();
                      print('押された');
                    },
                  ),
                ),
              ),
            )
        );
      }),
    );
  }
}
