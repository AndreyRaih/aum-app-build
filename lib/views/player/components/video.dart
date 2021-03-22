import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

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
