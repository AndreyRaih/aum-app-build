import 'package:aum_app_build/data/models/user.dart';

abstract class UserState {
  const UserState();
}

class UserInit extends UserState {
  const UserInit();
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
  final Map personalSession;
  final String avatarUrl;
  const UserSuccess(this.user, {this.personalSession, this.avatarUrl}) : assert(user != null);

  List get lastWeekSessions => user.sessions.where((element) => _dateWeekFilter(element["date"])).toList();
}

bool _dateWeekFilter(String date) {
  DateTime _date = DateTime.parse(date);
  DateTime _weekStart = DateTime.now().subtract(Duration(days: 7));
  return _date.compareTo(_weekStart) > 0;
}
