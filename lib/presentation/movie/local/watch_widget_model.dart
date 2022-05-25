import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class WatchWidgetModel extends ChangeNotifier {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  //late Future<void> _initializeVideoPlayerFuture;

  File? video;
  final picker = ImagePicker();

    Future openVideoPlayer() async {
      Wakelock.enable();
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      videoPlayerController = VideoPlayerController.file(File(pickedFile!.path));
      await _initVideoController();
      videoPlayerController!.play();
      notifyListeners();
    }

  Future _initVideoController() async {
    await videoPlayerController!.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      aspectRatio: videoPlayerController!.value.aspectRatio,
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
    await videoPlayerController!.dispose();
    super.dispose();
  }
}
