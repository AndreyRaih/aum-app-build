import 'package:aum_app_build/common_bloc/navigator/navigator_state.dart';
import 'package:aum_app_build/common_bloc/onboarding/onboarding_state.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigatorCubit extends Cubit<NavigatorCubitState> {
  final GlobalKey<NavigatorState> navigatorKey;
  NavigatorCubit({this.navigatorKey}) : super(NavigatorInitial());

  void navigatorPop() => navigatorKey.currentState.pop();
  void navigatorPush(route, {dynamic arguments}) => navigatorKey.currentState.pushNamed(route, arguments: arguments);
  void createOnboardingRouteHook(
    String route,
    OnboardingTarget target, {
    AumUser user,
    dynamic arguments,
  }) {
    this.navigatorPush(route, arguments: arguments);
    switch (target) {
      case OnboardingTarget.concept:
        if (user == null || !user.onboardingComplete.concept) {
          this.navigatorPush(CONCEPT_ONBOARDING_ROUTE_NAME);
        }
        break;
      case OnboardingTarget.player:
        if (user == null || !user.onboardingComplete.player) {
          this.navigatorPush(PLAYER_ONBOARDING_ROUTE_NAME);
        }
        break;
      default:
        this.navigatorPush(route, arguments: arguments);
        break;
    }
  }
}
