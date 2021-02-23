import 'package:aum_app_build/utils/pose_estimation.dart';
import 'package:flutter/material.dart';

class PosePoints extends StatelessWidget {
  final List<PoseEstimateEntity> points;
  PosePoints(this.points);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderPoints = points
        .map<Widget>((dot) => _Point(
              x: dot.x,
              y: dot.y,
              highlight: dot.isActive,
            ))
        .toList();
    return Stack(children: _renderPoints);
  }
}

class _Point extends StatelessWidget {
  final double x;
  final double y;
  final bool highlight;

  _Point({this.x = 0, this.y = 0, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    Color _color = highlight ? Colors.green[700] : Colors.white;
    return AnimatedPositioned(
        top: y,
        left: x,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: _color),
        ),
        duration: Duration(milliseconds: 500));
  }
}
