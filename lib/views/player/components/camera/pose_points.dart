import 'package:aum_app_build/utils/pose_estimation.dart';
import 'package:flutter/material.dart';

class PosePoints extends StatelessWidget {
  final List<PosePoint> points;
  PosePoints(this.points);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderPoints = points
        .map<Widget>((dot) => AnimatedPositioned(
            top: dot.y,
            left: dot.x,
            child: Row(children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.5)),
              ),
            ]),
            duration: Duration(milliseconds: 800)))
        .toList();
    return Stack(children: _renderPoints);
  }
}
