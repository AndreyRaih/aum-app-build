import 'package:flutter/material.dart';

class Segment extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  Segment(
      {@required this.child,
      this.padding = const EdgeInsets.all(24.0),
      this.margin = const EdgeInsets.all(0.0)});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: child);
  }
}
