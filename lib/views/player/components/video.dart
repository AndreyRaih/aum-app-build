import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/views/shared/audio.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/components/display.dart';
import 'package:aum_app_build/views/player/components/transition.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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
  final Duration _commonViewDuration = Duration(milliseconds: 500);

  CameraController _cameraController;
  VideoPlayerController _videoController;
  AumAppAudio _voice = AumAppAudio();
  bool _contentIsReady = false;

  double _xMove = 0;
  double _yMove = 0;
  double _height = 0;
  double _width = 0;

  @override
  void initState() {
    super.initState();
    _videoPartStart(context);
  }

  @override
  void didUpdateWidget(PlayerVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    _videoPartStart(context);
  }

  @override
  void dispose() {
    _voice.stopAudio();
    _videoController?.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  void _reset() {
    _hideCamera();
    setState(() {
      _contentIsReady = false;
    });
  }

  void _videoPartStart(BuildContext context) async {
    _reset();
    await _initializeMedia();
    if (widget.asana.isCheck) {
      await _initializeCamera();
      await _startCheck(context);
    }
    _videoController.play();
    _voice.playAudio(widget.audioSrc, volume: 0.5);
    setState(() {
      _contentIsReady = true;
    });
  }

  Future _initializeMedia() async {
    _videoController = VideoPlayerController.network(widget.asana.url);
    _videoController.addListener(() {
      if (_videoController.value.position == _videoController.value.duration) {
        BlocProvider.of<PlayerBloc>(context).add(GetPlayerNextPart());
      }
    });
    return _videoController.initialize();
  }

  Future _initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    if (cameras == null || cameras.length < 1) {
      print('No camera is found');
    } else {
      _cameraController = new CameraController(
        cameras[1],
        ResolutionPreset.high,
      );
      return _cameraController.initialize();
    }
  }

  Future _startCheck(BuildContext context) async {
    _showCamera(context);
    setState(() {
      _contentIsReady = true;
    });
    return Future.delayed(Duration(seconds: 10))
        .then((_) => _minimizeCamera(context));
  }

  void _showCamera(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    setState(() {
      _xMove = 0;
      _yMove = 0;
      _height = size.height;
      _width = size.width;
    });
  }

  void _minimizeCamera(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    setState(() {
      _xMove = size.width - 245;
      _yMove = 25;
      _height = 130;
      _width = 220;
    });
  }

  void _hideCamera() => setState(() {
        _xMove = 0;
        _yMove = 0;
        _height = 0;
        _width = 0;
      });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: AnimatedSwitcher(
          duration: _commonViewDuration,
          transitionBuilder: (Widget child, Animation<double> animation) =>
              FadeTransition(child: child, opacity: animation),
          child: _contentIsReady
              ? Stack(children: [
                  PlayerScreenVideo(controller: _videoController),
                  AnimatedPositioned(
                    left: _xMove,
                    top: _yMove,
                    child: AnimatedContainer(
                      height: _height,
                      width: _width,
                      duration: _commonViewDuration,
                      curve: Curves.easeInOut,
                      child: PlayerScreenCamera(
                        controller: _cameraController,
                      ),
                    ),
                    duration: _commonViewDuration,
                    curve: Curves.easeInOut,
                  ),
                ])
              : PlayerTransition(text: widget.asana.name),
        ));
  }
}
