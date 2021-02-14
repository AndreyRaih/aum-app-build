import 'dart:ui';

import 'package:aum_app_build/views/player/components/content.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

const double CAMERA_X_OFFSET = 245;
const double CAMERA_Y_OFFSET = 155;
const double CAMERA_MINIMIZE_HEIGHT = 130;
const double CAMERA_MINIMIZE_WIDTH = 220;
const Size DEFAULT_CAMERA_MINIMIZE_SIZE = Size(CAMERA_MINIMIZE_WIDTH, CAMERA_MINIMIZE_HEIGHT);

class MinimizedContentView extends StatefulWidget {
  final Widget child;
  final bool active;
  final bool minimize;
  final Duration duration;
  MinimizedContentView(
      {Key key,
      @required this.child,
      this.active = false,
      this.minimize = false,
      this.duration = COMMON_PLAYER_ANIMATION_DURATION})
      : super(key: key);
  @override
  _MinimizedContentViewState createState() => _MinimizedContentViewState();
}

class _MinimizedContentViewState extends State<MinimizedContentView> {
  Size _size;

  double _xMove = 0;
  double _yMove = 0;
  double _height = 0;
  double _width = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;
    _showCamera();
  }

  @override
  void didUpdateWidget(covariant MinimizedContentView oldWidget) {
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
            child: widget.child,
          )),
      duration: widget.duration,
      curve: Curves.easeInOut,
    );
  }
}
