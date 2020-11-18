import 'package:aum_app_build/data/content_repository.dart';
import 'package:aum_app_build/data/models/video.dart';
import 'package:wakelock/wakelock.dart';
import 'package:aum_app_build/views/shared/audio.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/components/display.dart';
import 'package:aum_app_build/views/shared/transition.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class PlayerVideo extends StatefulWidget {
  final AsanaVideoSource asana;
  PlayerVideo(this.asana, {Key key}) : assert(asana != null);

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

  bool _startCapturing = false;

  @override
  void initState() {
    Wakelock.enable();
    _videoPartStart(context);
    super.initState();
  }

  @override
  void dispose() {
    Wakelock.disable();
    _voice.stopAudio();
    _videoController?.dispose();
    _cameraController?.dispose();
    _hideCamera();
    setState(() {
      _contentIsReady = false;
    });
    super.dispose();
  }

  void _videoPartStart(BuildContext context) async {
    await _initializeMedia();
    /* if (widget.asana.isCheck != null && widget.asana.isCheck) {
      await _initializeCamera();
      await _startCheck(context);
    } */
    await _initializeCamera();
    await _startCheck(context);
    _videoController.play();
    String _audioUrl =
        await ContentRepository().getStorageDownloadURL(widget.asana.audio);
    _voice.playAudio(_audioUrl, volume: 0.5);
    setState(() {
      _contentIsReady = true;
    });
  }

  Future _initializeMedia() async {
    String _videoURL =
        await ContentRepository().getStorageDownloadURL(widget.asana.src);
    _videoController = VideoPlayerController.network(_videoURL);
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
      _yMove = size.height - 155;
      _height = 130;
      _width = 220;
      _startCapturing = true;
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
                        key: UniqueKey(),
                        controller: _cameraController,
                        captureIsActive: _startCapturing,
                        asana: widget.asana,
                      ),
                    ),
                    duration: _commonViewDuration,
                    curve: Curves.easeInOut,
                  ),
                ])
              : AumTransition(text: widget.asana.name),
        ));
  }
}
