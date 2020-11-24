import 'dart:async';
import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/views/onboarding/bloc/introduction/introduction_event.dart';
import 'package:aum_app_build/views/onboarding/bloc/introduction/introduction_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class IntroductionBloc extends Bloc<IntroductionEvent, IntroductionState> {
  final UserBloc userBloc;
  final NavigatorBloc navigatorBloc;
  final int maxStage;
  IntroductionBloc(
      {@required this.userBloc,
      @required this.navigatorBloc,
      this.maxStage = 1})
      : super(IntroductionStage(stage: 0));

  @override
  Stream<IntroductionState> mapEventToState(IntroductionEvent event) async* {
    if (event is IntroductionAwait) {
      yield IntroductionWaiting();
    } else if (event is IntroductionNext) {
      yield* _mapNextIntroductionStepToState(event);
    } else if (event is IntroductionSkip) {
      yield IntroductionStage(stage: 0);
      navigatorBloc.add(NavigatorPush(route: '/dashboard'));
    }
  }

  Stream<IntroductionState> _mapNextIntroductionStepToState(
      IntroductionNext event) async* {
    yield IntroductionWaiting();
    int _stage = (state as IntroductionStage).stage;
    int _nextStage = (state as IntroductionStage).stage + 1;
    if (_stage >= maxStage) {
      Map _endUpdates = {"hasIntroduction": true};
      userBloc.add(UpdateUser(_endUpdates));
      this.add(IntroductionSkip());
    }
    if (event.updates != null) {
      userBloc.add(UpdateUser(event.updates));
    }
    yield IntroductionStage(stage: _nextStage);
  }
}
