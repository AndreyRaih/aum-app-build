import 'package:aum_app_build/views/login/components/logo.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class LoginSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 60), child: LoginLogo()),
          AumText.bold(
            'Aum App',
            size: 34,
            align: TextAlign.center,
          ),
          AumText.medium(
            'Your daily Yoga practice created by AI',
            size: 16,
            color: AumColor.additional,
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}
