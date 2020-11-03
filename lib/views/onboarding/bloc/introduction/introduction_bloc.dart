import 'dart:async';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/views/onboarding/bloc/introduction/introduction_event.dart';
import 'package:aum_app_build/views/onboarding/bloc/introduction/introduction_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class IntroductionBloc extends Bloc<IntroductionEvent, IntroductionState> {
  final UserBloc userBloc;

  IntroductionBloc({@required this.userBloc})
      : super(IntroductionStage(stage: 0));

  @override
  Stream<IntroductionState> mapEventToState(IntroductionEvent event) async* {
    if (event is IntroductionNext) {
      yield* _mapNextIntroductionStepToState(event);
    } else if (event is SetIntroductionStage) {
      yield IntroductionStage(stage: event.stage);
    } else if (event is IntroductionSkip) {
      yield IntroductionStage(stage: 0);
    } else if (event is IntroductionAwait) {
      yield IntroductionWaiting();
    }
  }

  Stream<IntroductionState> _mapNextIntroductionStepToState(
      IntroductionNext event) async* {
    if (event.updates != null) {
      await userBloc.add(UpdateUser(event.updates));
    }
    int _currentStage = (state as IntroductionStage).stage + 1;
    this.add(SetIntroductionStage(stage: _currentStage));
  }
}
