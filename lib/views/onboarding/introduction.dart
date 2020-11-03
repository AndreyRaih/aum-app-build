import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/views/onboarding/bloc/introduction/introduction_bloc.dart';
import 'package:aum_app_build/views/onboarding/bloc/introduction/introduction_event.dart';
import 'package:aum_app_build/views/onboarding/bloc/introduction/introduction_state.dart';
import 'package:aum_app_build/views/onboarding/components/introduction/actions.dart';
import 'package:aum_app_build/views/onboarding/components/introduction/main_data.dart';
import 'package:aum_app_build/views/onboarding/components/introduction/skills_data.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingIntroductionScreen extends StatefulWidget {
  @override
  _OnboardingIntroductionScreenState createState() =>
      _OnboardingIntroductionScreenState();
}

class _OnboardingIntroductionScreenState
    extends State<OnboardingIntroductionScreen> {
  Map<String, String> _updates;

  @override
  Widget build(BuildContext context) {
    final IntroductionBloc introductionBloc =
        IntroductionBloc(userBloc: BlocProvider.of<UserBloc>(context));
    return BlocBuilder<IntroductionBloc, IntroductionState>(
        bloc: introductionBloc,
        builder: (context, state) {
          if (state is IntroductionStage) {
            Widget _currentStage;
            switch (state.stage) {
              case 0:
                _currentStage = IntroductionBodyDataForm(
                  onUpdate: (String value) {
                    setState(() {
                      _updates =
                          value != null && value != '' ? {"name": value} : null;
                    });
                  },
                );
                break;
              case 1:
                _currentStage = IntroductionSkillsDataForm(
                  onCheck: () {},
                );
                break;
              default:
                _currentStage = IntroductionBodyDataForm();
                break;
            }
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
                          _currentStage,
                          (state is IntroductionWaiting)
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AumColor.accent),
                                )
                              : Container()
                        ])),
                    IntroductionActions(
                      stage: state.stage,
                      onNext: () {
                        if (state.stage < 1) {
                          introductionBloc
                              .add(IntroductionNext(updates: _updates));
                        } else {
                          introductionBloc.add(IntroductionSkip());
                          BlocProvider.of<NavigatorBloc>(context)
                              .add(NavigatorPush(route: '/dashboard'));
                        }
                      },
                      onSkip: () {
                        introductionBloc.add(IntroductionSkip());
                        BlocProvider.of<NavigatorBloc>(context)
                            .add(NavigatorPush(route: '/dashboard'));
                      },
                    )
                  ],
                ));
          } else {
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AumColor.accent),
            );
          }
        });
  }
}
