import 'package:aum_app_build/data/models/user.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/input.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/rating.dart';
import 'package:aum_app_build/views/shared/select.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class IntroductionSkillsDataForm extends StatelessWidget {
  final Function onCheck;
  IntroductionSkillsDataForm({this.onCheck});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: _SkillsDataFormDescription()),
        AumSecondaryButton(
          onPressed: onCheck,
          text: 'start check-session',
        )
      ],
    );
  }
}

class _SkillsDataFormDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AumText.bold(
          'What about your skills?',
          size: 34,
          align: TextAlign.center,
        ),
        AumText.medium(
          'Choose your level or use our AI powered check-session',
          size: 16,
          align: TextAlign.center,
          color: AumColor.additional,
        )
      ],
    );
  }
}
