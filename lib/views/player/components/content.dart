import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/views/player/components/camera/camera.dart';
import 'package:aum_app_build/views/player/components/video.dart';
import 'package:aum_app_build/views/shared/audio.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:aum_app_build/data/content_repository.dart';
import 'package:wakelock/wakelock.dart';
import 'package:aum_app_build/views/player/bloc/player/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player/player_event.dart';
import 'package:aum_app_build/views/shared/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const Duration COMMON_PLAYER_ANIMATION_DURATION = Duration(milliseconds: 500);

class PlayerContent extends StatefulWidget {
  final AsanaItem asana;
  final AsanaVideoFragment sources;
  PlayerContent(this.asana, this.sources, {Key key}) : assert(asana != null, sources != null);

  @override
  _PlayerContentState createState() => _PlayerContentState();
}

class _PlayerContentState extends State<PlayerContent> {
  AumAudio _voice;

  CameraController _cameraController;
  VideoPlayerController _videoController;

  bool _isLoading = true;

  bool _cameraIsActive = false;
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
      await _initResources();
      if (_isCheckAsana) {
        await _checkStart();
      }
      await _playResources();
      _showContentView();
      if (_isCheckAsana) {
        _checkAwait();
      }
    }
  }

  void _playerStop() async {
    await _clearResources();
  }

  Future _initResources() async {
    await _initializeVideo();
    await _initializeAudio();
  }

  Future _playResources() async {
    _voice.play();
    await _videoController.play();
  }

  Future _clearResources() async {
    _voice.stop();
    _videoController?.dispose();
    _cameraController?.dispose();
  }

  Future _initializeAudio() async {
    String _audioUrl = await ContentRepository().getStorageDownloadURL(widget.sources.audioSrc);
    return _voice = AumAudio(uri: _audioUrl);
  }

  Future _initializeVideo() async {
    String _videoURL = await ContentRepository().getStorageDownloadURL(widget.sources.videoSrc);
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

  void _showContentView() {
    if (mounted) {
      setState(() {
        _isLoading = false;
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
  }

  void _checkAwait() {
    Future.delayed(Duration(seconds: 3)).then((value) => _hideCameraView());
  }

  void _checkCapture() {
    _showCameraView();
    Future.delayed(Duration(seconds: 2)).then((value) => setState(() => _cameraIsCapturing = true));
    Future.delayed(Duration(seconds: 22)).then((value) => _hideCameraView());
  }

  String _normalizeAsanaName(String base) => (base[0].toUpperCase() + base.substring(1)).replaceAll('_', ' ');

  @override
  Widget build(BuildContext context) {
    // _cameraIsCapturing -> Bloc's prop
    // _cameraIsActive -> Bloc's prop
    // _cameraIsMini -> Bloc's prop
    String _name = _normalizeAsanaName(widget.asana.name);
    Widget _content = AnimatedSwitcher(
        duration: COMMON_PLAYER_ANIMATION_DURATION,
        transitionBuilder: (Widget child, Animation<double> animation) =>
            FadeTransition(child: child, opacity: animation),
        child: _cameraIsActive
            ? PlayerCamera(
                _cameraController,
                widget.asana,
                captureIsActive: _cameraIsCapturing,
                screen: MediaQuery.of(context).size,
              )
            : PlayerScreenVideo(controller: _videoController));
    return Container(
        width: MediaQuery.of(context).size.width,
        child: AnimatedSwitcher(
            duration: COMMON_PLAYER_ANIMATION_DURATION,
            transitionBuilder: (Widget child, Animation<double> animation) =>
                FadeTransition(child: child, opacity: animation),
            child: _isLoading ? AumTransition(text: _name) : _content));
  }
}
