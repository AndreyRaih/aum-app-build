import 'dart:ui';

import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/utils/pose_estimation.dart';
import 'package:aum_app_build/views/player/bloc/pose_estimation/estimation_bloc.dart';
import 'package:aum_app_build/views/player/bloc/pose_estimation/estimation_event.dart';
import 'package:aum_app_build/views/player/bloc/pose_estimation/estimation_state.dart';
import 'package:aum_app_build/views/player/components/camera/estimation_overlay.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerCamera extends StatefulWidget {
  final AsanaItem asana;
  final CameraController controller;
  final bool captureIsActive;
  final Size screen;
  PlayerCamera(this.controller, this.asana, {Key key, this.captureIsActive = false, this.screen}) : super(key: key);

  @override
  _PlayerCameraState createState() => _PlayerCameraState();
}

class _PlayerCameraState extends State<PlayerCamera> with SingleTickerProviderStateMixin {
  PoseAnalyser _analyser = PoseAnalyser();
  bool _capturingInProgress = false;

  @override
  void initState() {
    super.initState();
    _analyser.loadModel();
  }

  void _capture(BuildContext context) async {
    if (widget.controller.value.isStreamingImages) {
      await widget.controller.stopImageStream();
    }
    widget.controller.startImageStream((CameraImage img) async {
      if (!_capturingInProgress) {
        _capturingInProgress = true;
        List<PoseEstimateEntity> _keypoints = await _analyser.estimate(img, screen: widget.screen);
        BlocProvider.of<EstimationBloc>(context).add(EstimationCreatePointsEvent(_keypoints, widget.asana));
        _capturingInProgress = false;
      }
    });
  }

  @override
  void didUpdateWidget(PlayerCamera oldWidget) {
    if (widget.captureIsActive && mounted) {
      _capture(context);
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
    return BlocBuilder<EstimationBloc, EstimationBlocState>(builder: (context, state) {
      List<PoseEstimateEntity> _points = (state is EstimationActive) ? state.points : [];
      Widget _cameraView = widget.controller == null ? _noCamera : _camera;
      Widget _captureOverlay = widget.captureIsActive ? EstimationOverlay(_points) : Container();
      return Stack(
        alignment: Alignment.center,
        children: [
          _cameraView,
          _captureOverlay,
        ],
      );
    });
  }
}
