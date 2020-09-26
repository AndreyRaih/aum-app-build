import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/icons.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
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
          color: Colors.black.withOpacity(0.25),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(120),
              topRight: Radius.circular(120))),
      child: Icon(AumIcon.arrow_left, color: Colors.white, size: 54));
  static final Widget _rightControll = Container(
      height: 120,
      width: 60,
      padding: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(120), topLeft: Radius.circular(120))),
      child: Icon(AumIcon.arrow_right, color: Colors.white, size: 54));

  static Widget leftControll({VoidCallback onControllTap}) {
    return PlayerMainControlls(
        onControllTap: onControllTap, child: _leftControll);
  }

  static Widget rightControll({VoidCallback onControllTap}) {
    return PlayerMainControlls(
        onControllTap: onControllTap, child: _rightControll);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: child, onTap: onControllTap);
  }
}

class PlayerAsanaPresentor extends StatelessWidget {
  final String name;
  final int position;
  final int practiceLength;
  PlayerAsanaPresentor(
      {@required this.name, this.position, this.practiceLength});

  Widget _buildTrackDot(int dotIndex) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: dotIndex == position
              ? AumColor.accent
              : Colors.black.withOpacity(0.25)),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasTraking = position != null &&
        practiceLength != null &&
        position <= practiceLength;
    List<Widget> _asanaTrack = hasTraking
        ? new List.generate(practiceLength, (i) => i + 1)
            .map((e) => _buildTrackDot(e))
            .toList()
        : null;
    return hasTraking
        ? Column(
            children: [
              _PlayerControllWrapper(
                child: AumText.medium(name, color: Colors.white, size: 28),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: _asanaTrack,
                  ))
            ],
          )
        : Column(children: [
            _PlayerControllWrapper(
              child: AumText.medium(name, color: Colors.white, size: 28),
            )
          ]);
  }
}

class PlayerTimer extends StatefulWidget {
  _PlayerTimerState createState() => _PlayerTimerState();
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

class _PlayerTimerState extends State<PlayerTimer> {
  @override
  Widget build(BuildContext context) {
    return _PlayerControllWrapper(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              AumIcon.timer_breathe_circle,
              color: Colors.white,
              size: 42,
            )),
        AumText.medium(
          '5',
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
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
          borderRadius: BorderRadius.circular(16)),
    );
  }
}
