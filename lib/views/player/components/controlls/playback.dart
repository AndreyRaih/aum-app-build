import 'package:aum_app_build/views/shared/icons.dart';
import 'package:flutter/material.dart';

class PlayerPlaybackControlls extends StatelessWidget {
  final VoidCallback onControllTap;
  final Widget child;

  PlayerPlaybackControlls({@required this.onControllTap, @required this.child});

  static final Widget _leftControll = Container(
      height: 120,
      width: 60,
      padding: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(120), topRight: Radius.circular(120))),
      child: Icon(AumIcon.arrow_left, color: Colors.white, size: 54));
  static final Widget _rightControll = Container(
      height: 120,
      width: 60,
      padding: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120), topLeft: Radius.circular(120))),
      child: Icon(AumIcon.arrow_right, color: Colors.white, size: 54));

  static Widget leftControll({VoidCallback onControllTap}) {
    return PlayerPlaybackControlls(onControllTap: onControllTap, child: _leftControll);
  }

  static Widget rightControll({VoidCallback onControllTap}) {
    return PlayerPlaybackControlls(onControllTap: onControllTap, child: _rightControll);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: child, onTap: onControllTap);
  }
}
