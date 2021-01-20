import 'package:aum_app_build/data/content_repository.dart';
import 'package:aum_app_build/data/models/video.dart';
import 'package:aum_app_build/utils/data.dart';
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
  AumAudio _voice;

  CameraController _cameraController;
  VideoPlayerController _videoController;

  bool _contentIsReady = false;

  bool _cameraIsActive = false;
  bool _cameraIsMini = false;
  bool _cameraIsCapturing = false;

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
    if (mounted) {
      bool _isCheckAsana = widget.asana.isCheck != null && widget.asana.isCheck;
      await _initializeVideo();
      await _initializeAudio();
      if (_isCheckAsana) {
        await _checkStart();
      }
      _voice.play();
      _videoController.play();
      _showContentView();
      if (_isCheckAsana) {
        _checkAwait();
      }
    }
  }

  void _playerStop() {
    _voice.stop();
    _videoController?.dispose();
    _cameraController?.dispose();
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

  Future _initializeAudio() async {
    String _audioUrl = await ContentRepository().getStorageDownloadURL(widget.asana.audio);
    return _voice = AumAudio(uri: _audioUrl);
  }

  void _showContentView() {
    if (mounted) {
      setState(() {
        _contentIsReady = true;
      });
    }
  }

  void _showCameraView() {
    if (mounted) {
      setState(() {
        _cameraIsActive = true;
      });
    }
  }

  void _hideCameraView() {
    if (mounted) {
      setState(() {
        _cameraIsActive = false;
      });
    }
  }

  void _changeCameraViewSize({bool isMinimize}) {
    if (mounted) {
      setState(() => _cameraIsMini = isMinimize);
    }
  }

  Future _checkStart() async {
    Duration _captureTime = widget.asana.captureTime;
    await _initializeCamera();
    _showCameraView();
    _showContentView();
    _videoController.addListener(() {
      if (_videoController.value.position.inSeconds == _captureTime.inSeconds) {
        _checkCapture();
      }
    });
    await Future.delayed(Duration(seconds: 5)).then((_) {
      _changeCameraViewSize(isMinimize: true);
    });
  }

  void _checkAwait() {
    Future.delayed(Duration(seconds: 3)).then((value) => _hideCameraView());
  }

  void _checkCapture() {
    _showCameraView();
    Future.delayed(Duration(seconds: 2)).then((value) => setState(() => _cameraIsCapturing = true));
    Future.delayed(Duration(seconds: 22)).then((value) => _hideCameraView());
  }

  @override
  Widget build(BuildContext context) {
    String _name = normalizeAsanaName(widget.asana.name);
    Widget _contentWidget = _contentIsReady
        ? Stack(children: [
            PlayerScreenVideo(controller: _videoController),
            _AnimatedCameraView(
                controller: _cameraController,
                active: _cameraIsActive,
                minimize: _cameraIsMini,
                capturing: _cameraIsCapturing,
                duration: _commonAnimationDuration,
                asana: widget.asana),
          ])
        : AumTransition(text: _name);
    return Container(
        width: MediaQuery.of(context).size.width,
        child: AnimatedSwitcher(
            duration: _commonAnimationDuration,
            transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(child: child, opacity: animation),
            child: _contentWidget));
  }
}

class _AnimatedCameraView extends StatefulWidget {
  final CameraController controller;
  final bool active;
  final bool minimize;
  final bool capturing;
  final Duration duration;
  final AsanaVideoSource asana;
  _AnimatedCameraView(
      {Key key,
      @required this.controller,
      @required this.asana,
      this.active = false,
      this.minimize = false,
      this.capturing = false,
      this.duration = const Duration(milliseconds: 800)})
      : super(key: key);
  @override
  __AnimatedCameraViewState createState() => __AnimatedCameraViewState();
}

const double CAMERA_X_OFFSET = 245;
const double CAMERA_Y_OFFSET = 155;
const double CAMERA_MINIMIZE_HEIGHT = 130;
const double CAMERA_MINIMIZE_WIDTH = 220;

class __AnimatedCameraViewState extends State<_AnimatedCameraView> {
  Size _size;

  double _xMove = 0;
  double _yMove = 0;
  double _height = 0;
  double _width = 0;

  bool _capturingStart = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;
    _showCamera();
  }

  @override
  void didUpdateWidget(covariant _AnimatedCameraView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _cameraAction();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _cameraAction() {
    if (widget.active) {
      _showCamera();
    }
    if (!widget.active) {
      _hideCamera();
    }
    if (widget.capturing) {
      _startCapturing();
    }
    if (widget.minimize) {
      _minimizeCamera();
    }
  }

  void _showCamera() => setState(() {
        _xMove = 0;
        _yMove = 0;
        _height = _size.height;
        _width = _size.width;
      });

  void _hideCamera() => setState(() {
        _height = 0;
        _width = 0;
      });

  void _minimizeCamera() => setState(() {
        _xMove = _size.width - CAMERA_X_OFFSET;
        _yMove = _size.height - CAMERA_Y_OFFSET;
        _height = CAMERA_MINIMIZE_HEIGHT;
        _width = CAMERA_MINIMIZE_WIDTH;
      });

  void _startCapturing() => setState(() {
        _capturingStart = true;
      });

  @override
  Widget build(BuildContext context) {
    double opacity = widget.active ? 1.0 : 0;
    return AnimatedPositioned(
      left: _xMove,
      top: _yMove,
      child: AnimatedOpacity(
          opacity: opacity,
          duration: widget.duration,
          child: AnimatedContainer(
            height: _height,
            width: _width,
            duration: widget.duration,
            curve: Curves.easeInOut,
            child: PlayerScreenCamera(
              controller: widget.controller,
              captureIsActive: _capturingStart,
              asana: widget.asana,
            ),
          )),
      duration: widget.duration,
      curve: Curves.easeInOut,
    );
  }
}
