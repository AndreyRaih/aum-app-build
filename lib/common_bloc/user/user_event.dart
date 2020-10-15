import 'package:aum_app_build/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserEvent {
  const UserEvent();
}

class UserNotFound extends UserEvent {
  const UserNotFound();
}

class GetUser extends UserEvent {
  const GetUser();
}

class SignUp extends UserEvent {
  final String name;
  final String email;
  final String password;
  const SignUp({this.name, this.email, this.password});
}

class SignIn extends UserEvent {
  final String email;
  final String password;
  const SignIn({this.email, this.password});
}

class CheckUserLoginState extends UserEvent {
  const CheckUserLoginState();
}