import 'package:aum_app_build/utils/pose_estimation.dart';
import 'package:flutter/material.dart';

class EstimationOverlay extends StatelessWidget {
  final List<PoseEstimateEntity> points;
  EstimationOverlay(this.points);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderPoints = points
        .map<Widget>((dot) => _Point(
              x: dot.x,
              y: dot.y,
              highlight: dot.isActive,
            ))
        .toList();
    Widget _renderLines = CustomPaint(
      painter: _LinesPainter(points),
      size: MediaQuery.of(context).size,
    );
    return Stack(children: [_renderLines, ..._renderPoints]);
  }
}

class _Point extends StatelessWidget {
  final double x;
  final double y;
  final bool highlight;

  _Point({this.x = 0, this.y = 0, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    Color _color = highlight ? Colors.green[700] : Colors.white70;
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

class _LinesPainter extends CustomPainter {
  List<PoseEstimateEntity> points;
  _LinesPainter(points);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    print(size);
    points.forEach((_point) {
      PoseEstimateEntity _nextPoint = points.firstWhere((element) => element.part == _point.nextPart);
      print('draw');
      canvas.drawLine(Offset(_point.x, _point.y), Offset(_nextPoint.x, _nextPoint.y), paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
