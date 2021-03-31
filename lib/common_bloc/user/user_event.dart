import 'package:aum_app_build/data/models/user.dart';

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

class SetUserModel extends UserEvent {
  final AumUser user;
  const SetUserModel(this.user);
}

class SetUserError extends UserEvent {
  const SetUserError();
}
