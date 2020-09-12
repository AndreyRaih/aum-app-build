import 'package:aum_app_build/views/ui/icons.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class DashboardAdviceComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_AdviceIcon(), _Advice()],
    );
  }
}

class _Advice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
          AumText.bold('Piece of advice', size: 16.0),
          AumText.regular(
              'If you spend 15 minutes practicing, in 2 hours your cortisol level will drop to the daily norm',
              size: 14.0)
        ]));
  }
}

class _AdviceIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(right: 8.0),
      decoration:
          BoxDecoration(color: AumColor.secondary, shape: BoxShape.circle),
      child: Center(
          child: Icon(
        AumIcon.info,
        color: AumColor.accent,
      )),
    );
  }
}
