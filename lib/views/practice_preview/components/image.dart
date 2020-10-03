import 'package:aum_app_build/views/ui/palette.dart';
import 'package:flutter/material.dart';

class PreviewImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 340,
        decoration: BoxDecoration(
            color: AumColor.accent,
            image: DecorationImage(
                image: AssetImage('img/dashboard_2.png'),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter)));
  }
}
