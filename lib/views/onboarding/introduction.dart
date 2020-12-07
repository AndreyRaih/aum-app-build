import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/views/onboarding/components/introduction/user.dart';
import 'package:aum_app_build/views/onboarding/components/introduction/skills.dart';
import 'package:aum_app_build/views/onboarding/components/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingIntroductionScreen extends StatefulWidget {
  @override
  _OnboardingIntroductionScreenState createState() => _OnboardingIntroductionScreenState();
}

class _OnboardingIntroductionScreenState extends State<OnboardingIntroductionScreen> {
  Map _updates = {};
  List<Widget> _screens;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initScreens(context);
  }

  void _initScreens(context) =>
      setState(() => _screens = [IntroductionUserStep(onUpdate: _setUpdates), IntroductionSkillStep(onCheck: () => _checkSkills(context))]);

  void _checkSkills(BuildContext context) =>
      BlocProvider.of<NavigatorBloc>(context).add(NavigatorPush(route: CHECK_PROGRESS_ROUTE_NAME, arguments: PracticePreferences()));

  void _setUpdates(Map value) => setState(() => _updates = value);

  void _endIntroductionOnboarding(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(UpdateUserModel(_updates));
    BlocProvider.of<UserBloc>(context).add(CompleteUserOnboarding(ONBOARDING_INTRODUCTION_NAME));
    BlocProvider.of<NavigatorBloc>(context).add(NavigatorPop());
  }

  @override
  Widget build(BuildContext context) => OnboardingStepperScreen(
        steps: _screens,
        onStepsEnd: () => _endIntroductionOnboarding(context),
      );
}
