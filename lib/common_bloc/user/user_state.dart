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

class UserNoExist extends UserState {
  const UserNoExist();
}

class UserIsDefined extends UserState {
  final AumUser user;
  final Map personalSession;
  const UserIsDefined(this.user, {this.personalSession}) : assert(user != null);

  List get lastWeekSessions => user.sessions.where((element) => _dateWeekFilter(element["date"])).toList();
}

bool _dateWeekFilter(String date) {
  DateTime _date = DateTime.parse(date);
  DateTime _weekStart = DateTime.now().subtract(Duration(days: 7));
  return _date.compareTo(_weekStart) > 0;
}
