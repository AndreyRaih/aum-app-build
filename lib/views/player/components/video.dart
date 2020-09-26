import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/components/camera.dart';
import 'package:aum_app_build/views/player/components/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class PlayerVideo extends StatefulWidget {
  final AsanaVideoPart asana;
  PlayerVideo(this.asana) : assert(asana != null);

  @override
  _PlayerVideoState createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo> {
  VideoPlayerController controller;
  Widget _videoView;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    controller = VideoPlayerController.network(widget.asana.url);
    controller.addListener(() {
      if (controller.value.position == controller.value.duration) {
        BlocProvider.of<PlayerBloc>(context).add(GetPlayerNextPart());
      }
    });
    setState(() {
      _videoView = _Video(controller);
    });
    await controller.initialize();
    await controller.play();
  }

  Widget _renderCurrentVideoPart(AsanaVideoPart part) {
    return part.isCheck
        ? Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [PlayerCamera(), _videoView],
          )
        : _videoView;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 700),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          FadeTransition(child: child, opacity: animation),
      child: controller != null || controller.value.isPlaying
          ? _renderCurrentVideoPart(widget.asana)
          : PlayerTransition(text: widget.asana.name),
    );
  }
}

class _Video extends StatelessWidget {
  VideoPlayerController controller;
  _Video(this.controller) : assert(controller != null);

  Widget _renderVideo(BuildContext context) {
    if (controller.value.initialized) {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      );
    } else {
      return Placeholder(
        fallbackWidth: MediaQuery.of(context).size.width,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(child: _renderVideo(context)));
  }
}
