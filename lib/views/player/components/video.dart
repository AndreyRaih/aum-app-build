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
  final Duration _commonAnimationDuration = Duration(milliseconds: 500);
  final AumAppAudio _voice = AumAppAudio();

  CameraController _cameraController;
  VideoPlayerController _videoController;

  bool _contentIsReady = false;
  bool _startCapturing = false;
  bool _isCheckMode = false;
  bool _isMinimize = false;

  @override
  void initState() {
    Wakelock.enable();
    _playerStart(context);
    super.initState();
  }

  @override
  void dispose() {
    Wakelock.disable();
    _playerStop();
    super.dispose();
  }

  void _playerStart(BuildContext context) async {
    await _initializeVideo();
    if (widget.asana.isCheck != null && widget.asana.isCheck) {
      await _startCheck(context);
    }
    if (mounted) {
      await _initializeAndPlayAudio();
      _videoController.play();
      _showContent();
    }
  }

  Future _initializeVideo() async {
    String _videoURL = await ContentRepository().getStorageDownloadURL(widget.asana.src);
    _videoController = VideoPlayerController.network(_videoURL);
    _videoController.addListener(() {
      if (_videoController.value.position == _videoController.value.duration) {
        BlocProvider.of<PlayerBloc>(context).add(GetPlayerNextPart());
      }
    });
    return _videoController.initialize();
  }

  Future _initializeAndPlayAudio() async {
    String _audioUrl = await ContentRepository().getStorageDownloadURL(widget.asana.audio);
    return _voice.playAudio(_audioUrl);
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
    await _initializeCamera();
    _showContent(isCheck: true);
    return Future.delayed(Duration(seconds: 10)).then((_) {
      if (mounted) {
        setState(() => _isMinimize = true);
      }
    });
  }

  void _playerStop() {
    _voice.stopAudio();
    _videoController?.dispose();
    _cameraController?.dispose();
  }

  void _showContent({bool isCheck = false}) => setState(() {
        _contentIsReady = true;
        _isCheckMode = isCheck;
      });

  @override
  Widget build(BuildContext context) {
    Widget _cameraWidget = _isCheckMode
        ? _AnimatedCameraView(
            duration: _commonAnimationDuration,
            minimize: _isMinimize,
            child: PlayerScreenCamera(
              controller: _cameraController,
              captureIsActive: _startCapturing,
              asana: widget.asana,
            ),
          )
        : Container();

    return Container(
        width: MediaQuery.of(context).size.width,
        child: AnimatedSwitcher(
          duration: _commonAnimationDuration,
          transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(child: child, opacity: animation),
          child: _contentIsReady
              ? Stack(children: [
                  PlayerScreenVideo(controller: _videoController),
                  _cameraWidget,
                ])
              : AumTransition(text: widget.asana.name),
        ));
  }
}

class _AnimatedCameraView extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final bool minimize;
  _AnimatedCameraView({@required this.child, this.duration, this.minimize = false, Key key}) : super(key: key);
  @override
  __AnimatedCameraViewState createState() => __AnimatedCameraViewState();
}

class __AnimatedCameraViewState extends State<_AnimatedCameraView> {
  Size _size;

  double _xMove = 0;
  double _yMove = 0;
  double _height = 0;
  double _width = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;
    _showCamera(context);
  }

  @override
  void didUpdateWidget(covariant _AnimatedCameraView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.minimize) {
      _minimizeCamera(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showCamera(BuildContext context) {
    setState(() {
      _xMove = 0;
      _yMove = 0;
      _height = _size.height;
      _width = _size.width;
    });
  }

  void _minimizeCamera(BuildContext context) {
    setState(() {
      _xMove = _size.width - 245;
      _yMove = _size.height - 155;
      _height = 130;
      _width = 220;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: _xMove,
      top: _yMove,
      child: AnimatedContainer(
        height: _height,
        width: _width,
        duration: widget.duration,
        curve: Curves.easeInOut,
        child: widget.child,
      ),
      duration: widget.duration,
      curve: Curves.easeInOut,
    );
  }
}
