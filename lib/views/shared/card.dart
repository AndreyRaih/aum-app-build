import 'package:aum_app_build/views/shared/shadows.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class AumCard extends StatelessWidget {
  final double padding;
  final double margin;
  final Widget child;

  final double _borderRadius = 30.0;

  AumCard({this.padding = MIDDLE_OFFSET, this.margin = MIDDLE_OFFSET, this.child});

  @override
  Widget build(BuildContext context) {
    Widget _container = child != null ? child : Container();
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(_borderRadius), boxShadow: AumShadow.soft),
        margin: EdgeInsets.symmetric(vertical: margin),
        child: _container);
  }
}
