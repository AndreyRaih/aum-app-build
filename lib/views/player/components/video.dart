import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class PlayerVideo extends StatefulWidget {
  VoidCallback onChangeVideo;
  PlayerVideo({this.onChangeVideo});
  @override
  _PlayerVideoState createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo> {
  VideoPlayerController _controller;
  int _currentPosition = 0;
  List<String> _videos = [
    'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/balances_1%2Fstanding-balances_1.mp4?alt=media&token=0f146711-87cf-4552-9b8d-192358d53c4e',
    'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/balances_1%2Ftree-balances_1.mp4?alt=media&token=82dd8761-39a8-46bb-809e-effa2030e433',
    'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/balances_1%2Fwarrior_left-balances_1.mp4?alt=media&token=8f295bbd-d364-4992-aeaa-c8ab808ba7e6',
    'https://firebasestorage.googleapis.com/v0/b/aum-app-videos/o/balances_1%2Fwarrior_right-balances_1.mp4?alt=media&token=6473e2c8-b52b-4087-aec0-9ef9f21228fe'
  ];
  @override
  void initState() {
    super.initState();
    _setNextVideoPart();
  }

  void _setNextVideoPart() async {
    widget.onChangeVideo();
    String url = _videos[_currentPosition];
    await _setVideoPart(url);
    setState(() {
      if (_currentPosition < 3) {
        _currentPosition++;
      } else {
        _currentPosition = 0;
      }
    });
  }

  Future _setVideoPart(String url) async {
    _controller = VideoPlayerController.network(url);
    await _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        _setNextVideoPart();
      }
    });
    await _controller.initialize();
    await _controller.play();
  }

  Widget _renderVideo() {
    if (_controller.value.initialized) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      );
    } else {
      return Placeholder(
        fallbackWidth: MediaQuery.of(context).size.width,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(child: _renderVideo()));
  }
}
