import 'dart:async';

import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class PlayerTransition extends StatelessWidget {
  final String text;
  PlayerTransition({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          children: [
            Center(child: _TransitionShadowAnimated()),
            Center(
              child: AumText.bold(
                text,
                size: 36,
                color: AumColor.accent,
              ),
            ),
          ],
        ));
  }
}

class _TransitionShadowAnimated extends StatefulWidget {
  _TransitionShadowAnimatedState createState() =>
      _TransitionShadowAnimatedState();
}

class _TransitionShadowAnimatedState extends State<_TransitionShadowAnimated>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _fadeValue;
  double _previewCircleSize = 0;
  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 3400), vsync: this);
    _fadeValue = Tween<double>(begin: 1, end: 0).animate(_controller);
    _startAnimation();
  }

  void _startAnimation() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      _getResizeShadow();
    });
  }

  void _getResizeShadow() {
    if (_previewCircleSize == 0) {
      _controller.reset();
      _controller.forward();
      setState(() {
        _previewCircleSize = MediaQuery.of(context).size.height;
      });
    } else {
      setState(() {
        _previewCircleSize = 0;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeValue,
      child: AnimatedContainer(
        width: _previewCircleSize,
        height: _previewCircleSize,
        decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(0, 0),
                  blurRadius: 25,
                  spreadRadius: 0)
            ]),
        duration: Duration(seconds: 3),
        curve: Curves.easeIn,
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(0, 0),
                    blurRadius: 30,
                    spreadRadius: 0)
              ]),
        ),
      ),
    );
  }
}
