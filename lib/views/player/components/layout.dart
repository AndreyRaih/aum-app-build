import 'dart:async';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class PlayerLayout extends StatefulWidget {
  final Widget contain;
  final Widget left;
  final Widget right;
  final Widget topRight;
  final Widget top;
  final Widget topLeft;
  final Widget bottom;
  PlayerLayout({this.contain, this.left, this.right, this.top, this.topLeft, this.topRight, this.bottom, Key key}) : super(key: key);

  @override
  _PlayerLayoutState createState() => _PlayerLayoutState();
}

class _PlayerLayoutState extends State<PlayerLayout> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _leftControllAnimation;
  Animation<Offset> _rightControllAnimation;
  Animation<Offset> _topControllAnimation;
  Animation<Offset> _bottomControllAnimation;
  Animation<double> _fadeElementAnimation;

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
    _leftControllAnimation = _buildControllerAnimationTween(const Offset(-10, 0));
    _rightControllAnimation = _buildControllerAnimationTween(const Offset(10, 0));
    _topControllAnimation = _buildControllerAnimationTween(const Offset(0, -10.0));
    _bottomControllAnimation = _buildControllerAnimationTween(const Offset(0, 10));
    _fadeElementAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  Animation<Offset> _buildControllerAnimationTween(Offset begin) {
    return Tween<Offset>(
      begin: begin,
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutExpo,
    ));
  }

  void _showControlls() {
    if (mounted) _controller.forward();
    Timer(const Duration(seconds: 3), () {
      if (mounted) _controller.reverse();
    });
  }

  Widget _makeAnimateLayoutElement({Animation<Offset> position, EdgeInsets padding = const EdgeInsets.all(0), Animation<double> opacity, Widget child}) {
    return SlideTransition(
        position: position,
        child: Center(
          child: Padding(padding: padding, child: FadeTransition(opacity: opacity == null ? 1 : opacity, child: child != null ? child : Container())),
        ));
  }

  Widget _renderLayout() {
    return GestureDetector(
        onTap: () {
          _showControlls();
        },
        child: Stack(
          children: [
            widget.contain,
            Positioned(left: 24, top: 24, child: widget.topLeft != null ? widget.topLeft : Container()),
            Positioned(right: 24, top: 24, child: widget.topRight != null ? widget.topRight : Container()),
            Center(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      _makeAnimateLayoutElement(position: _topControllAnimation, opacity: _fadeElementAnimation, child: widget.top),
                      _makeAnimateLayoutElement(position: _bottomControllAnimation, opacity: _fadeElementAnimation, child: widget.bottom)
                    ]))),
            Center(
                child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _makeAnimateLayoutElement(position: _leftControllAnimation, opacity: _fadeElementAnimation, child: widget.left),
                _makeAnimateLayoutElement(position: _rightControllAnimation, opacity: _fadeElementAnimation, child: widget.right),
              ],
            )),
          ],
        ));
  }

  Widget _renderOrientationWarning() {
    return Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.grey[300]),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
          child: AumText(
            'Please turn your phone in lanscape orientation',
            align: TextAlign.center,
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.landscape ? _renderLayout() : _renderOrientationWarning();
    });
  }
}
