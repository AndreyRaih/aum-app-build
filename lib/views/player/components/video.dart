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
  Widget _contentView;
  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void didUpdateWidget(PlayerVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initializeVideo();
  }

  void _initializeVideo() async {
    setState(() {
      _contentView = null;
    });
    controller = VideoPlayerController.network(widget.asana.url);
    controller.addListener(() {
      if (controller.value.position == controller.value.duration) {
        BlocProvider.of<PlayerBloc>(context).add(GetPlayerNextPart());
      }
    });
    await controller.initialize();
    await Future.delayed(Duration(milliseconds: 1500))
        .then((_) => _setContentView());
    controller.play();
  }

  Future _setContentView() async {
    if (widget.asana.isCheck) {
      setState(() {
        _contentView = PlayerCamera();
      });
    }
    return Future.delayed(Duration(seconds: widget.asana.isCheck ? 20 : 0))
        .then((_) => setState(() {
              _contentView = _Video(controller);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              FadeTransition(child: child, opacity: animation),
          child: _contentView != null
              ? _contentView
              : PlayerTransition(text: widget.asana.name),
        ));
  }
}

class _Video extends StatelessWidget {
  final VideoPlayerController controller;
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
    return Center(child: _renderVideo(context));
  }
}
