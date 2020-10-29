import 'package:aum_app_build/views/onboarding/components/introduction/actions.dart';
import 'package:aum_app_build/views/onboarding/components/introduction/main_data.dart';
import 'package:aum_app_build/views/onboarding/components/introduction/skills_data.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:flutter/material.dart';

class OnboardingIntroductionScreen extends StatelessWidget {
  bool _loadInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  IntroductionSkillsDataForm(),
                  _loadInProgress
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AumColor.accent),
                        )
                      : Container()
                ])),
            IntroductionActions()
          ],
        ));
  }
}
