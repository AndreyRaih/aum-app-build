import 'dart:async';
import 'package:aum_app_build/common_bloc/onboarding/onboarding_state.dart';
import 'package:aum_app_build/data/user_repository.dart';
import 'package:bloc/bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final UserRepository userRepository = UserRepository();

  OnboardingCubit() : super(OnboardingInitial());

  Future completeOnboarding(OnboardingTarget target) async {
    String _name;
    switch (target) {
      case OnboardingTarget.concept:
        _name = "concept";
        break;
      case OnboardingTarget.player:
        _name = "player";
        break;
    }
    await userRepository.onboardingComplete(_name);
  }
}
