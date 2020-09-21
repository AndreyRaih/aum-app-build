import 'package:aum_app_build/views/player/components/controlls.dart';
import 'package:aum_app_build/views/player/components/video.dart';
import 'package:aum_app_build/views/ui/icons.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _PlayerLayout(
      contain: PlayerVideo(),
      left: PlayerMainControlls.leftControll(),
      right: PlayerMainControlls.rightControll(),
      topRight: PlayerTimer(),
      topLeft: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(right: 16),
              child: PlayerControllButton(icon: AumIcon.cancel)),
          PlayerControllButton(icon: AumIcon.audion_controll)
        ],
      ),
      top: PlayerAsanaPresentor(
        name: 'utthita trikoṇāsana',
        position: 2,
        practiceLength: 6,
      ),
    );
  }
}

class _PlayerLayout extends StatelessWidget {
  final Widget contain;
  final Widget left;
  final Widget right;
  final Widget topRight;
  final Widget top;
  final Widget topLeft;
  _PlayerLayout(
      {this.contain,
      this.left,
      this.right,
      this.top,
      this.topLeft,
      this.topRight});
  @override
  Widget build(BuildContext context) {
    Widget _renderLayout() {
      return Stack(
        children: [
          contain,
          Positioned(
              left: 24,
              top: 24,
              child: topLeft != null ? topLeft : Container()),
          Positioned(
              right: 24,
              top: 24,
              child: topRight != null ? topRight : Container()),
          Center(
            child: Padding(
                padding: EdgeInsets.only(top: 24),
                child: top != null ? top : Container()),
          ),
          Center(
              child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              left != null ? left : Container(),
              right != null ? right : Container(),
            ],
          ))
        ],
      );
    }

    Widget _renderOrientationWarning() {
      return Center(
        child: AumText('Please turn your phone in lanscape orientation'),
      );
    }

    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.landscape
          ? _renderLayout()
          : _renderOrientationWarning();
    });
  }
}
