import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/data/models/user.dart';
import 'package:flutter/material.dart';

abstract class UserEvent {
  const UserEvent();
}

class StartUserSession extends UserEvent {
  const StartUserSession();
}

class EndUserSession extends UserEvent {
  const EndUserSession();
}

class ResetUserSession extends UserEvent {
  const ResetUserSession();
}

class SaveUserResult extends UserEvent {
  final int asanaCount;
  final int range;
  const SaveUserResult({this.asanaCount, this.range});
}

class SetUserAsanaResult extends UserEvent {
  final AsanaEstimationResult result;
  const SetUserAsanaResult(this.result);
}

class UpdateUserModel extends UserEvent {
  final Map updates;
  const UpdateUserModel(this.updates);
}

enum UserOnboardingTarget { player, concept }

class UserOnboardingRouteHook extends UserEvent {
  final UserOnboardingTarget onboardingTarget;
  final String route;
  final dynamic arguments;
  const UserOnboardingRouteHook({@required this.onboardingTarget, @required this.route, this.arguments});
}

class CompleteUserOnboarding extends UserEvent {
  final UserOnboardingTarget name;
  const CompleteUserOnboarding(this.name);
}

class SetUserModel extends UserEvent {
  final AumUser user;
  const SetUserModel(this.user);
}

class SetUserError extends UserEvent {
  const SetUserError();
}

class UserSignUp extends UserEvent {
  final AumUserCreateModel data;
  const UserSignUp(this.data);
}

class UserSignIn extends UserEvent {
  final AumUserCreateModel data;
  const UserSignIn(this.data);
}
