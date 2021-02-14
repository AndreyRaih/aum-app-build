import 'package:aum_app_build/data/models/video.dart';
import 'package:aum_app_build/views/player/components/camera/camera.dart';
import 'package:aum_app_build/views/player/components/controlls/minimized_content_view.dart';
import 'package:aum_app_build/views/player/components/video.dart';
import 'package:aum_app_build/views/shared/audio.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:aum_app_build/data/content_repository.dart';
import 'package:aum_app_build/utils/data.dart';
import 'package:wakelock/wakelock.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/shared/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const Duration COMMON_PLAYER_ANIMATION_DURATION = Duration(milliseconds: 500);

class PlayerContent extends StatefulWidget {
  final AsanaVideoSource asana;
  PlayerContent(this.asana, {Key key}) : assert(asana != null);

  @override
  _PlayerContentState createState() => _PlayerContentState();
}

class _PlayerContentState extends State<PlayerContent> {
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
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _playerStart(context);
    super.didChangeDependencies();
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
            MinimizedContentView(
                child: PlayerCamera(
                  controller: _cameraController,
                  captureIsActive: _cameraIsCapturing,
                ),
                active: _cameraIsActive,
                minimize: _cameraIsMini),
          ])
        : AumTransition(text: _name);
    return Container(
        width: MediaQuery.of(context).size.width,
        child: AnimatedSwitcher(
            duration: COMMON_PLAYER_ANIMATION_DURATION,
            transitionBuilder: (Widget child, Animation<double> animation) =>
                FadeTransition(child: child, opacity: animation),
            child: _contentWidget));
  }
}
