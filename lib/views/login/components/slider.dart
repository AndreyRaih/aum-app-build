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
          Padding(padding: EdgeInsets.only(bottom: 48), child: LoginLogo()),
          AumText.bold(
            'Title',
            size: 34,
            align: TextAlign.center,
          ),
          AumText.medium(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            size: 16,
            color: AumColor.additional,
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}
