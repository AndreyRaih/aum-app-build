import 'dart:ui';

import 'package:aum_app_build/utils/pose_estimation.dart';
import 'package:aum_app_build/views/player/components/controlls/minimized_content_view.dart';
import 'package:aum_app_build/views/player/components/camera/pose_points.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PlayerCamera extends StatefulWidget {
  final CameraController controller;
  final bool captureIsActive;
  final Size screen;
  PlayerCamera({Key key, this.controller, this.captureIsActive = false, this.screen = DEFAULT_CAMERA_MINIMIZE_SIZE})
      : super(key: key);

  @override
  _PlayerCameraState createState() => _PlayerCameraState();
}

class _PlayerCameraState extends State<PlayerCamera> with SingleTickerProviderStateMixin {
  PoseAnalyser _analyser = PoseAnalyser();
  List<PosePoint> _points = [];

  bool _capturingInProgress = false;

  @override
  void initState() {
    super.initState();
    _analyser.loadModel();
  }

  void _capture() async {
    if (widget.controller.value.isStreamingImages) {
      await widget.controller.stopImageStream();
    }
    widget.controller.startImageStream((CameraImage img) async {
      if (!_capturingInProgress) {
        _capturingInProgress = true;
        List<PosePoint> _keypoints = await _analyser.estimate(img, screen: widget.screen);
        if (_keypoints.length > 0) {
          setState(() => _points = _keypoints.where((_point) => _point.x > 0 && _point.y > 0).toList());
        }
        _capturingInProgress = false;
      }
    });
  }

  @override
  void didUpdateWidget(PlayerCamera oldWidget) {
    if (widget.captureIsActive && mounted) {
      _capture();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _noCamera = Container(
      child: Center(
          child: AumText.bold(
        'No capturing',
        color: Colors.white,
      )),
    );
    Widget _camera = AspectRatio(
      aspectRatio: widget.controller.value.aspectRatio,
      child: CameraPreview(widget.controller),
    );
    Widget _cameraView = widget.controller == null ? _noCamera : _camera;
    Widget _captureOverlay = widget.captureIsActive ? PosePoints(_points) : Container();
    return Stack(
      alignment: Alignment.center,
      children: [
        _cameraView,
        _captureOverlay,
      ],
    );
  }
}
