import 'dart:async';

import 'package:aum_app_build/views/player/components/controlls.dart';
import 'package:aum_app_build/views/player/components/transition.dart';
import 'package:aum_app_build/views/player/components/video.dart';
import 'package:aum_app_build/views/ui/icons.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool isShowPreview = false;

  void _showAsanaPreview() {
    setState(() {
      isShowPreview = true;
    });
    Timer(const Duration(seconds: 5), () {
      setState(() {
        isShowPreview = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _PlayerLayout(
      contain: !isShowPreview
          ? PlayerTransition(text: 'Trikonasana')
          : PlayerVideo(),
      left: PlayerMainControlls.leftControll(onControllTap: () {
        _showAsanaPreview();
      }),
      right: PlayerMainControlls.rightControll(onControllTap: () {
        _showAsanaPreview();
      }),
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

class _PlayerLayout extends StatefulWidget {
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
  __PlayerLayoutState createState() => __PlayerLayoutState();
}

class __PlayerLayoutState extends State<_PlayerLayout>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _leftControllAnimation;
  Animation<Offset> _rightControllAnimation;
  Animation<Offset> _topControllAnimation;

  @override
  void initState() {
    super.initState();
    _initControllsAnimations();
  }

  void _initControllsAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      reverseDuration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _leftControllAnimation = _buildAnimationTween(const Offset(-10, 0));
    _rightControllAnimation = _buildAnimationTween(const Offset(10, 0));
    _topControllAnimation = _buildAnimationTween(const Offset(0, -10.0));
  }

  Animation<Offset> _buildAnimationTween(Offset begin) {
    return Tween<Offset>(
      begin: begin,
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutExpo,
    ));
  }

  void _showControlls() {
    _controller.forward();
    Timer(const Duration(seconds: 3), () {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _renderLayout() {
      return GestureDetector(
          onTap: () {
            _showControlls();
          },
          child: Stack(
            children: [
              widget.contain,
              Positioned(
                  left: 24,
                  top: 24,
                  child: widget.topLeft != null ? widget.topLeft : Container()),
              Positioned(
                  right: 24,
                  top: 24,
                  child:
                      widget.topRight != null ? widget.topRight : Container()),
              SlideTransition(
                position: _topControllAnimation,
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: widget.top != null ? widget.top : Container()),
                ),
              ),
              Center(
                  child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SlideTransition(
                    position: _leftControllAnimation,
                    child: widget.left != null ? widget.left : Container(),
                  ),
                  SlideTransition(
                    position: _rightControllAnimation,
                    child: widget.right != null ? widget.right : Container(),
                  ),
                ],
              ))
            ],
          ));
    }

    Widget _renderOrientationWarning() {
      return Container(
          decoration: BoxDecoration(color: Colors.grey[300]),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Center(
            child: AumText('Please turn your phone in lanscape orientation'),
          ));
    }

    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.landscape
          ? _renderLayout()
          : _renderOrientationWarning();
    });
  }
}
