import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/views/onboarding/components/how_it_works.dart';
import 'package:aum_app_build/views/onboarding/components/main.dart';
import 'package:aum_app_build/views/shared/stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingConceptScreen extends StatelessWidget {
  final List<Widget> _screens = [
    ConceptMainStep(),
    ConceptHowItWorksStep(),
  ];

  void _endIntroductionOnboarding(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(CompleteUserOnboarding(ONBOARDING_CONCEPT_NAME));
    BlocProvider.of<NavigatorBloc>(context).add(NavigatorPop());
  }

  @override
  Widget build(BuildContext context) => Container(
      color: Colors.white,
      padding: EdgeInsets.all(24),
      child: AumStepper(
        steps: _screens,
        wideIndicators: true,
        onStepsEnd: () => _endIntroductionOnboarding(context),
      ));
}
