import 'package:firebase_auth/firebase_auth.dart';

abstract class UserEvent {
  const UserEvent();
}

class UserNotFound extends UserEvent {
  const UserNotFound();
}

class SetUser extends UserEvent {
  final User user;
  const SetUser(this.user) : assert(user != null);
}

class CreateNewUser extends UserEvent {
  final String email;
  final String password;
  const CreateNewUser({this.email, this.password});
}

class SignIn extends UserEvent {
  final String email;
  final String password;
  const SignIn({this.email, this.password});
}
