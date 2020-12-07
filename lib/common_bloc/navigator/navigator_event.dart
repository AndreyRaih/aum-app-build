import 'package:flutter/material.dart';

abstract class NavigatorEvent {
  const NavigatorEvent();
}

class NavigatorPush extends NavigatorEvent {
  final String route;
  final dynamic arguments;
  const NavigatorPush({this.route, this.arguments});
}

class NavigatorPushWithOnboardingHook extends NavigatorEvent {
  final Map onboardingState;
  final String onboardingTarget;
  final String route;
  final dynamic arguments;
  const NavigatorPushWithOnboardingHook({@required this.onboardingState, @required this.onboardingTarget, @required this.route, this.arguments});
}

class NavigatorPop extends NavigatorEvent {
  const NavigatorPop();
}
