import 'package:aum_app_build/views/ui/palette.dart';
import 'package:flutter/material.dart';

class PreviewImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        height: 340,
        decoration: BoxDecoration(color: AumColor.accent),
        child: Image.asset('img/dashboard_2.png'));
  }
}
