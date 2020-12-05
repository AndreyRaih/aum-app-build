import 'package:aum_app_build/views/shared/stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnboardingStepperScreen extends StatelessWidget {
  final List<Widget> steps;
  final Function onStepsEnd;
  const OnboardingStepperScreen({@required this.steps, this.onStepsEnd});
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, padding: EdgeInsets.all(24), child: AumStepper(steps: steps, wideIndicators: true, onStepsEnd: onStepsEnd));
  }
}
