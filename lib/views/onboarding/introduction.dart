import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/onboarding/bloc/introduction/introduction_bloc.dart';
import 'package:aum_app_build/views/onboarding/bloc/introduction/introduction_event.dart';
import 'package:aum_app_build/views/onboarding/bloc/introduction/introduction_state.dart';
import 'package:aum_app_build/views/onboarding/components/introduction/actions.dart';
import 'package:aum_app_build/views/onboarding/components/introduction/main_data.dart';
import 'package:aum_app_build/views/onboarding/components/introduction/skills_data.dart';
import 'package:aum_app_build/views/shared/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingIntroductionScreen extends StatefulWidget {
  @override
  _OnboardingIntroductionScreenState createState() =>
      _OnboardingIntroductionScreenState();
}

class _OnboardingIntroductionScreenState
    extends State<OnboardingIntroductionScreen> {
  Map _updates;

  void _checkSkills(BuildContext context) =>
      BlocProvider.of<NavigatorBloc>(context).add(
          NavigatorPush(route: '/check', arguments: PracticePreferences()));

  void _setUpdates(Map value) => setState(() => _updates = value);

  Widget _defineStageView(int stage) {
    switch (stage) {
      case 0:
        return IntroductionBodyDataForm(
            onUpdate: (value) => _setUpdates(value));
      case 1:
        return IntroductionSkillsDataForm(
          onCheck: () => _checkSkills(context),
        );
      default:
        return Center(child: AumLoader());
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final IntroductionBloc introductionBloc = IntroductionBloc(
        userBloc: BlocProvider.of<UserBloc>(context),
        navigatorBloc: BlocProvider.of<NavigatorBloc>(context));

    return BlocBuilder<IntroductionBloc, IntroductionState>(
        bloc: introductionBloc,
        builder: (context, state) {
          if (state is IntroductionStage) {
            Widget _currentStage = _defineStageView(state.stage);
            return Container(
                color: Colors.white,
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: _currentStage),
                    IntroductionActions(
                      stage: state.stage,
                      onNext: () => introductionBloc
                          .add(IntroductionNext(updates: _updates)),
                      onSkip: () => introductionBloc.add(IntroductionSkip()),
                    )
                  ],
                ));
          } else {
            return Center(child: AumLoader());
          }
        });
  }
}
