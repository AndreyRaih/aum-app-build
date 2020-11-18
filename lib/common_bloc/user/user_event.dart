import 'package:aum_app_build/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserEvent {
  const UserEvent();
}

class InitializeUserSession extends UserEvent {
  const InitializeUserSession();
}

class GetUser extends UserEvent {
  const GetUser();
}

class SetUser extends UserEvent {
  final AumUser user;
  const SetUser(this.user);
}

class UpdateUser extends UserEvent {
  final Map<String, String> updates;
  const UpdateUser(this.updates);
}

class SaveUserSession extends UserEvent {
  final int asanaCount;
  final int range;
  const SaveUserSession({this.asanaCount, this.range});
}

class SignUp extends UserEvent {
  final String email;
  final String password;
  const SignUp({this.email, this.password});
}

class SignIn extends UserEvent {
  final String email;
  final String password;
  const SignIn({this.email, this.password});
}
