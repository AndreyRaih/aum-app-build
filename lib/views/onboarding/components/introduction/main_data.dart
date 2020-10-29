import 'package:aum_app_build/data/models/user.dart';
import 'package:aum_app_build/views/shared/input.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/select.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class IntroductionBodyDataForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: _BodyDataFormDescription()),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Container(
                width: 250,
                child: AumInput(
                  isCentered: true,
                  placeholder: 'Enter your name',
                )))
      ],
    );
  }
}

class _BodyDataFormDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AumText.bold(
          'Hello',
          size: 34,
          align: TextAlign.center,
        ),
        AumText.medium(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          size: 16,
          align: TextAlign.center,
          color: AumColor.additional,
        )
      ],
    );
  }
}
