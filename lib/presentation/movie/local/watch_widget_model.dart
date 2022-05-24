import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class WatchWidgetModel extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  late Future<void> _initializeVideoPlayerFuture;

  File? video;
  final picker = ImagePicker();

  Future openVideoPlayer() async {
    await _initVideoController();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      video = File(pickedFile.path);
      videoPlayerController = VideoPlayerController.file(video!);
      videoPlayerController.play();
    } else {
      print('画像が選択できませんでした。');
    }
  }

  WatchWidgetModel() {
    Wakelock.enable();
    Future initController() async {
      await _initVideoController();
      notifyListeners();
    }
  }

  Future _initVideoController() async {
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }

  void dispose() async {
    Wakelock.disable();
    chewieController?.dispose();
    await videoPlayerController.dispose();
    super.dispose();
  }
}
