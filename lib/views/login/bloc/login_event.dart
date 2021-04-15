import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginSignInInit extends LoginEvent {
  const LoginSignInInit();
}

class LoginSignInVerifyPhone extends LoginEvent {
  final String number;
  const LoginSignInVerifyPhone(this.number);
}

class LoginSignInCodeSent extends LoginEvent {
  final String code;
  const LoginSignInCodeSent(this.code);
}

class LoginSignInFailed extends LoginEvent {
  final FirebaseAuthException error;
  const LoginSignInFailed(this.error);
}

class LoginSignUpInit extends LoginEvent {
  const LoginSignUpInit();
}

class LoginUserProfileUpdated extends LoginEvent {
  const LoginUserProfileUpdated();
}

class LoginFinishedAumIntroduction extends LoginEvent {
  const LoginFinishedAumIntroduction();
}
