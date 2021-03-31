import 'package:aum_app_build/data/models/user.dart';

abstract class UserState {
  const UserState();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserFailure extends UserState {
  const UserFailure();
}

class UserEmpty extends UserState {
  const UserEmpty();
}

class UserSuccess extends UserState {
  final AumUser user;
  const UserSuccess(this.user) : assert(user != null);
}
