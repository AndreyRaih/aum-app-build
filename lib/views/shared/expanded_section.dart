import 'dart:math';

import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class AumExpandedSection extends StatefulWidget {
  final String label;
  final bool isExpand;
  final Widget content;
  AumExpandedSection(
      {@required this.label, @required this.content, this.isExpand = false});

  @override
  _AumExpandedSectionState createState() => _AumExpandedSectionState(
      label: label, content: content, isExpand: isExpand);
}

class _AumExpandedSectionState extends State<AumExpandedSection>
    with SingleTickerProviderStateMixin {
  final String label;
  final Widget content;
  bool isExpand = false;
  AnimationController _controller;
  Animation<double> _arrowAnimation;
  Animation<double> _expandAnimation;

  _AumExpandedSectionState(
      {@required this.label, @required this.content, this.isExpand = false});

  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 100));
    _arrowAnimation = Tween<double>(begin: -90, end: 0).animate(_controller);
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _arrowAnimation.addListener(() {
      setState(() {});
    });
  }

  void _toggleExpand() {
    if (!isExpand) {
      _showExpand();
    } else {
      _hideExpand();
    }
  }

  void _showExpand() {
    isExpand = true;
    _controller.forward();
  }

  void _hideExpand() {
    isExpand = false;
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        width: double.maxFinite,
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                  onTap: () {
                    _toggleExpand();
                  },
                  child: Stack(
                    children: [
                      Positioned(
                          top: 12,
                          child: Transform.rotate(
                              angle: _arrowAnimation.value * pi / 180,
                              child: Icon(
                                AumIcon.arrow_down,
                                color: Colors.grey[500],
                                size: 12,
                              ))),
                      Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: AumText.bold(label,
                              size: 24, color: AumColor.accent))
                    ],
                  )),
              SizeTransition(
                  axisAlignment: 1.0,
                  sizeFactor: _expandAnimation,
                  child: Padding(
                      padding: EdgeInsets.only(top: 16), child: content))
            ]));
  }
}
