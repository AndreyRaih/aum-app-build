import 'package:aum_app_build/common_bloc/navigator/navigator_cubit.dart';
import 'package:aum_app_build/common_bloc/onboarding/onboarding_cubit.dart';
import 'package:aum_app_build/common_bloc/onboarding/onboarding_state.dart';
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

  void _endIntroductionOnboarding(BuildContext context) async {
    BlocProvider.of<OnboardingCubit>(context).completeOnboarding(OnboardingTarget.concept);
    BlocProvider.of<NavigatorCubit>(context).navigatorPop();
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
