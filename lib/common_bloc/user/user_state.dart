import 'package:firebase_auth/firebase_auth.dart';

abstract class UserState {
  const UserState();
}

class UserNoExist extends UserState {
  const UserNoExist();
}

class UserIsDefined extends UserState {
  final User user;
  const UserIsDefined(this.user) : assert(user != null);
}

class UserCreatingProcess extends UserState {
  const UserCreatingProcess();
}

class UserLoginProcess extends UserState {
  const UserLoginProcess();
}

class UserError extends UserState {
  const UserError();
}
