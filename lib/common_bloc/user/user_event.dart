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

class UpdateUserModel extends UserEvent {
  final AumUserUpdatesModel updates;
  const UpdateUserModel(this.updates);
}

class SetUserModel extends UserEvent {
  final AumUser user;
  const SetUserModel(this.user);
}

class SetUserError extends UserEvent {
  const SetUserError();
}
