import 'package:aum_app_build/data/models/user.dart';

abstract class UserState {
  const UserState();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserNoExist extends UserState {
  const UserNoExist();
}

class UserIsDefined extends UserState {
  final AumUser user;
  const UserIsDefined(this.user) : assert(user != null);
}
