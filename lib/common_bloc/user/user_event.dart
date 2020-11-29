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

class SaveUserResult extends UserEvent {
  final int asanaCount;
  final int range;
  const SaveUserResult({this.asanaCount, this.range});
}

class UpdateUserModel extends UserEvent {
  final Map updates;
  const UpdateUserModel(this.updates);
}

class SetUserModel extends UserEvent {
  final AumUser user;
  final Map personalSession;
  const SetUserModel(this.user, {this.personalSession});
}

class UserSignUp extends UserEvent {
  final String email;
  final String password;
  const UserSignUp({this.email, this.password});
}

class UserSignIn extends UserEvent {
  final String email;
  final String password;
  const UserSignIn({this.email, this.password});
}
