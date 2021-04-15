abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginFailure extends LoginState {
  final String error;
  const LoginFailure(this.error);
}

class LoginSignIn extends LoginState {
  final String phone;
  const LoginSignIn({this.phone});
}

class LoginSignUp extends LoginState {
  const LoginSignUp();
}

class LoginAumIntroduction extends LoginState {
  const LoginAumIntroduction();
}
