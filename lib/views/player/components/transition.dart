import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class PlayerTransition extends StatelessWidget {
  final String text;
  PlayerTransition({@required this.text});
  GlobalKey _transition = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          children: [
            Center(child: _TransitionShadowAnimated(key: _transition)),
            Center(
              child: AumText.bold(
                text,
                size: 36,
                color: AumColor.accent,
                align: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}

class _TransitionShadowAnimated extends StatefulWidget {
  _TransitionShadowAnimated({Key key});
  _TransitionShadowAnimatedState createState() =>
      _TransitionShadowAnimatedState();
}

class _TransitionShadowAnimatedState extends State<_TransitionShadowAnimated>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _fadeValue;
  Animation<double> _sizeValue;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 3400), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      })
      ..addListener(() {
        setState(() {});
      });
    _fadeValue = Tween<double>(begin: 1, end: 0).animate(_controller);
    _sizeValue = Tween<double>(begin: 0, end: 400).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeValue,
      child: Container(
        width: _sizeValue.value,
        height: _sizeValue.value,
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
