import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/views/shared/audio.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:aum_app_build/data/content_repository.dart';
import 'package:wakelock/wakelock.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/shared/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const Duration COMMON_PLAYER_ANIMATION_DURATION = Duration(milliseconds: 500);

class PlayerContent extends StatefulWidget {
  final AsanaMediaFragment sources;
  PlayerContent(this.sources, {Key key}) : assert(sources != null);

  @override
  _PlayerContentState createState() => _PlayerContentState();
}

class _PlayerContentState extends State<PlayerContent> {
  AumAudio _voice;
  VideoPlayerController _videoController;

  bool _isLoading = true;

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
      await _initResources();
      await _playResources();
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _playerStop() async {
    if (mounted) {
      await _clearResources();
    }
  }

  Future _initResources() async {
    await _initializeVideo();
    await _initializeAudio();
  }

  Future _playResources() async {
    await _videoController.play();
    _voice.play();
  }

  Future _clearResources() async {
    _voice.stop();
    _videoController?.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: AnimatedSwitcher(
            duration: COMMON_PLAYER_ANIMATION_DURATION,
            transitionBuilder: (Widget child, Animation<double> animation) =>
                FadeTransition(child: child, opacity: animation),
            child: _isLoading
                ? AumTransition(text: widget.sources.displayingName)
                : _Video(controller: _videoController)));
  }
}

class _Video extends StatelessWidget {
  final VideoPlayerController controller;
  _Video({this.controller});
  @override
  Widget build(BuildContext context) {
    if (controller.value.initialized) {
      return Center(
          child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      ));
    } else {
      return Placeholder(
        fallbackWidth: MediaQuery.of(context).size.width,
      );
    }
  }
}
