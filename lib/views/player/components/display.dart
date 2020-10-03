import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';

class PlayerScreenCamera extends StatelessWidget {
  final CameraController controller;
  PlayerScreenCamera({this.controller});
  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }
    return RotatedBox(
      quarterTurns: -1,
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      ),
    );
  }
}

class PlayerScreenVideo extends StatelessWidget {
  final VideoPlayerController controller;
  PlayerScreenVideo({this.controller});
  @override
  Widget build(BuildContext context) {
    if (controller.value.initialized) {
      return Center(
          child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      ));
    } else {
      return Placeholder(
        fallbackWidth: MediaQuery.of(context).size.width,
      );
    }
  }
}
