import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPlayerScreen extends StatelessWidget {
  void _endIntroductionOnboarding(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(CompleteUserOnboarding(ONBOARDING_PLAYER_NAME));
    BlocProvider.of<NavigatorBloc>(context).add(NavigatorPop());
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(24),
        color: Colors.white,
        child: Column(children: [
          Expanded(
              child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(padding: EdgeInsets.only(bottom: 24), child: AumText.bold("Practice flow", size: 36)),
            AumText.medium(
              "After each asanas block, your camera will try to capture your static pose, during doing exercise",
              size: 18,
              color: AumColor.additional,
              align: TextAlign.center,
            ),
            Container(child: Image.asset(ONBOARDING_PLAYER_IMAGE)),
            AumText.medium(
              "This image will have analysed with ML, and results will be includes in your progress review. Please, care about good visibility, during your practice",
              size: 18,
              color: AumColor.additional,
              align: TextAlign.center,
            )
          ])),
          AumPrimaryButton(text: "Let's do practice", onPressed: () => _endIntroductionOnboarding(context))
        ]),
      );
}
