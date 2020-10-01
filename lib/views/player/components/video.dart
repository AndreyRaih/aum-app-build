import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/components/camera.dart';
import 'package:aum_app_build/views/player/components/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

enum AudioState { stopped, playing, paused }

class PlayerVideo extends StatefulWidget {
  final AsanaVideoPart asana;
  final String audioSrc;
  PlayerVideo(this.asana, {Key key, this.audioSrc})
      : assert(asana != null),
        super(key: key);

  @override
  _PlayerVideoState createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo> {
  VideoPlayerController _videoController;
  AudioPlayer _audioController;
  Widget _contentView;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void didUpdateWidget(PlayerVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    _resetControllers();
    _initializeVideo();
  }

  void _initializeVideo() async {
    setState(() {
      _contentView = null;
    });
    _videoController = VideoPlayerController.network(widget.asana.url);
    _audioController = AudioPlayer();
    _videoController.addListener(() {
      if (_videoController.value.position == _videoController.value.duration) {
        BlocProvider.of<PlayerBloc>(context).add(GetPlayerNextPart());
      }
    });
    await _videoController.initialize();
    await Future.delayed(Duration(milliseconds: 1500))
        .then((_) => _setContentView());
    _videoController.play();
    _audioController.play(widget.audioSrc);
  }

  void _resetControllers() {
    _audioController.dispose();
    _videoController.dispose();
  }

  Future _setContentView() async {
    if (widget.asana.isCheck) {
      setState(() {
        _contentView = PlayerCamera();
      });
    }
    return Future.delayed(Duration(seconds: widget.asana.isCheck ? 20 : 0))
        .then((_) => setState(() {
              _contentView = _Video(_videoController);
            }));
  }

  @override
  void dispose() {
    _audioController.dispose();
    _videoController.dispose();
    super.dispose();
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
