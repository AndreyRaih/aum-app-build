import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/components/camera.dart';
import 'package:aum_app_build/views/player/components/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';
import 'dart:async';

enum AudioState { stopped, playing, paused }

class PlayerVideo extends StatefulWidget {
  final AsanaVideoPart asana;
  final Map audioSettings;
  PlayerVideo(this.asana, {this.audioSettings}) : assert(asana != null);

  @override
  _PlayerVideoState createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo> {
  VideoPlayerController controller;
  Widget _contentView;
  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;
  AudioState playerState = AudioState.stopped;
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _initalizeAudio();
  }

  @override
  void didUpdateWidget(PlayerVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    _resetControllers();
    _initializeVideo();
    _initalizeAudio();
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
    play();
  }

  void _initalizeAudio() {
    audioPlayer = AudioPlayer();
  }

  void _resetControllers() {
    audioPlayer.stop();
    controller.dispose();
  }

  Future play() async {
    var src = widget.asana.audio.firstWhere((element) =>
        element["type"] == widget.audioSettings["type"] &&
        element["complexity"] == widget.audioSettings["complexity"]);
    await audioPlayer.play(src["url"]);
    setState(() {
      playerState = AudioState.playing;
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    setState(() => playerState = AudioState.stopped);
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
  void dispose() {
    audioPlayer.stop();
    controller.dispose();
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
