import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator/navigator_state.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorBlocState> {
  final GlobalKey<NavigatorState> navigatorKey;
  NavigatorBloc({this.navigatorKey}) : super(null);

  @override
  Stream<NavigatorBlocState> mapEventToState(NavigatorEvent event) async* {
    if (event is NavigatorPop) {
      navigatorKey.currentState.pop();
    } else if (event is NavigatorPush) {
      navigatorKey.currentState.pushNamed(event.route, arguments: event.arguments);
    } else if (event is NavigatorPushWithOnboardingHook) {
      navigatorKey.currentState.pushNamed(event.route, arguments: event.arguments);
      print('user state is ${event.onboardingState[event.onboardingTarget]}');
      if (!event.onboardingState[event.onboardingTarget]) {
        String _route = _mapOnboardingTargetToRoute(event.onboardingTarget);
        navigatorKey.currentState.pushNamed(_route);
      }
    }
  }

  String _mapOnboardingTargetToRoute(String onboarding) {
    switch (onboarding) {
      case ONBOARDING_INTRODUCTION_NAME:
        return INTRODUCTION_ONBOARDING_ROUTE_NAME;
        break;
      case ONBOARDING_CONCEPT_NAME:
        return CONCEPT_ONBOARDING_ROUTE_NAME;
        break;
      case ONBOARDING_PLAYER_NAME:
        return PLAYER_ONBOARDING_ROUTE_NAME;
        break;
      case ONBOARDING_PROGRESS_NAME:
        return PROGRESS_ONBOARDING_ROUTE_NAME;
        break;
      default:
        return INTRODUCTION_ONBOARDING_ROUTE_NAME;
    }
  }
}
