import 'dart:async';

import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class PlayerMainControlls extends StatelessWidget {
  final VoidCallback onControllTap;
  final Widget child;

  PlayerMainControlls({@required this.onControllTap, @required this.child});

  static final Widget _leftControll = Container(
      height: 120,
      width: 60,
      padding: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25), borderRadius: BorderRadius.only(bottomRight: Radius.circular(120), topRight: Radius.circular(120))),
      child: Icon(AumIcon.arrow_left, color: Colors.white, size: 54));
  static final Widget _rightControll = Container(
      height: 120,
      width: 60,
      padding: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120), topLeft: Radius.circular(120))),
      child: Icon(AumIcon.arrow_right, color: Colors.white, size: 54));

  static Widget leftControll({VoidCallback onControllTap}) {
    return PlayerMainControlls(onControllTap: onControllTap, child: _leftControll);
  }

  static Widget rightControll({VoidCallback onControllTap}) {
    return PlayerMainControlls(onControllTap: onControllTap, child: _rightControll);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: child, onTap: onControllTap);
  }
}

class PlayerAsanaName extends StatelessWidget {
  final String name;
  PlayerAsanaName({@required this.name});

  @override
  Widget build(BuildContext context) {
    return _PlayerControllWrapper(
      child: AumText.medium(name, color: Colors.white, size: 28),
    );
  }
}

class PlayerAsanaTrack extends StatelessWidget {
  final int position;
  final int practiceLength;
  PlayerAsanaTrack({this.position, this.practiceLength});

  Widget _buildTrackDot(int dotIndex) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(shape: BoxShape.circle, color: dotIndex == position ? AumColor.accent : Colors.black.withOpacity(0.25)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _asanaTrack = new List.generate(practiceLength, (i) => i + 1).map((e) => _buildTrackDot(e)).toList();
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _asanaTrack,
    );
  }
}

class PlayerTimer extends StatefulWidget {
  final TimerType type;
  PlayerTimer({this.type = TimerType.timer, Key key});
  _PlayerTimerState createState() => _PlayerTimerState();
}

class _PlayerTimerState extends State<PlayerTimer> {
  int _time = 0;
  Timer _counter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timerStart();
  }

  @override
  void dispose() {
    _counter.cancel();
    super.dispose();
  }

  void _timerStart() {
    int _startPoint = 0;
    int _delay = widget.type == TimerType.longTimer ? LONG_TIMER_DELAY : TIMER_DELAY;

    _counter = Timer.periodic(Duration(seconds: 1), (timer) {
      _startPoint++;
      if (_startPoint >= _delay) {
        setState(() {
          _time++;
        });
      }
    });
  }

  String _buildTimeStr(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return _PlayerControllWrapper(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              AumIcon.timer_seconds,
              color: Colors.white,
              size: 42,
            )),
        AumText.medium(
          _buildTimeStr(_time),
          color: Colors.white,
          size: 34,
        )
      ],
    ));
  }
}

class _PlayerControllWrapper extends StatelessWidget {
  final Widget child;
  _PlayerControllWrapper({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.25), borderRadius: BorderRadius.circular(16)),
    );
  }
}

class PlayerControllButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTapControll;
  PlayerControllButton({@required this.icon, this.onTapControll});

  @override
  Widget build(BuildContext context) {
    return AumCircularButton(
      onPressed: onTapControll,
      icon: icon,
      size: 28,
      fillColor: Colors.black.withOpacity(0.25),
    );
  }
}

enum TimerType { timer, breathe, longTimer }

const int TIMER_DELAY = 3;
const int LONG_TIMER_DELAY = 8;
