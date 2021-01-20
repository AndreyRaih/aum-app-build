import 'package:aum_app_build/data/content_repository.dart';
import 'package:aum_app_build/data/models/video.dart';
import 'package:aum_app_build/utils/data.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class PlayerScreenCamera extends StatefulWidget {
  final CameraController controller;
  final bool captureIsActive;
  final AsanaVideoSource asana;
  PlayerScreenCamera({this.controller, this.asana, this.captureIsActive = false, Key key}) : super(key: key);

  @override
  _PlayerScreenCameraState createState() => _PlayerScreenCameraState();
}

class _PlayerScreenCameraState extends State<PlayerScreenCamera> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  int _count = 1;

  bool _firstCapturing = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.75, end: 0.5).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ))
      ..addStatusListener((status) {
        if (_count < 5) {
          if (status == AnimationStatus.reverse) {
            setState(() {
              _count++;
            });
          }
        } else {
          if (status == AnimationStatus.forward) {
            setState(() {
              _animation = Tween<double>(begin: 0.75, end: 0).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.fastOutSlowIn,
              ));
            });
            if (widget.controller != null && widget.controller.value.isInitialized) {
              _capture();
            }
          }
          if (status == AnimationStatus.reverse) {
            _controller.stop();
          }
        }
      });
  }

  void _capture() async {
    final String _title = '${widget.asana.name.replaceAll(' ', '_')}-${widget.asana.block}';
    final String _filename = makeUniqueFileNameFromBasket(_title);
    final path = join((await getTemporaryDirectory()).path, '$_filename.png');
    if (_firstCapturing) {
      await widget.controller.takePicture(path);
      await ContentRepository().uploadImage(imageToUpload: File(path), filename: _filename);
      setState(() => _firstCapturing = false);
    }
  }

  @override
  void didUpdateWidget(covariant PlayerScreenCamera oldWidget) {
    if (widget.captureIsActive) {
      _controller.repeat(reverse: true);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _cameraView = widget.controller == null
        ? Container(
            child: Center(
                child: AumText.bold(
              'No capturing',
              color: Colors.white,
            )),
          )
        : RotatedBox(
            quarterTurns: -1,
            child: AspectRatio(
              aspectRatio: widget.controller.value.aspectRatio,
              child: CameraPreview(widget.controller),
            ),
          );
    Widget _captureOverlay = widget.captureIsActive
        ? ScaleTransition(
            scale: _animation,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 10, color: Colors.white)),
              child: Center(
                  child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 800),
                firstChild: AumText.bold(
                  _count.toString(),
                  size: 86,
                  color: Colors.white,
                ),
                secondChild: Icon(AumIcon.camera, size: 42, color: Colors.white),
                crossFadeState: _count < 5 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              )),
            ))
        : Container();
    return Stack(
      alignment: Alignment.center,
      children: [
        _cameraView,
        _captureOverlay,
      ],
    );
  }
}

class PlayerScreenVideo extends StatelessWidget {
  final VideoPlayerController controller;
  PlayerScreenVideo({this.controller});
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
