import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/data/models/routes.dart';
import 'package:aum_app_build/views/onboarding/components/introduction/main_data.dart';
import 'package:aum_app_build/views/onboarding/components/introduction/skills_data.dart';
import 'package:aum_app_build/views/shared/stepper.dart';
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
      setState(() => _screens = [IntroductionBodyDataForm(onUpdate: _setUpdates), IntroductionSkillsDataForm(onCheck: () => _checkSkills(context))]);

  void _checkSkills(BuildContext context) =>
      BlocProvider.of<NavigatorBloc>(context).add(NavigatorPush(route: CHECK_PROGRESS_ROUTE_NAME, arguments: PracticePreferences()));

  void _setUpdates(Map value) => setState(() => _updates = value);

  void _endIntroductionOnboarding(BuildContext context) {
    _updates["hasIntroduction"] = true;
    BlocProvider.of<UserBloc>(context).add(UpdateUserModel(_updates));
    BlocProvider.of<NavigatorBloc>(context).add(NavigatorPush(route: DASHBOARD_ROUTE_NAME));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(24),
        child: AumStepper(steps: _screens, wideIndicators: true, onStepsEnd: () => _endIntroductionOnboarding(context)));
  }
}
