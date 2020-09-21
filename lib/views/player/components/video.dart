import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class PlayerVideo extends StatefulWidget {
  @override
  _PlayerVideoState createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  Widget _renderVideo() {
    if (_controller.value.initialized) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      );
    } else {
      return Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Placeholder(
            fallbackWidth: MediaQuery.of(context).size.width,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _renderVideo();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
