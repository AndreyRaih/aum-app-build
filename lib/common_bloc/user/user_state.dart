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

  List get lastWeekSessions => user.sessions
      .where((element) => _dateWeekFilter(element["date"]))
      .toList();
}

bool _dateWeekFilter(String date) {
  DateTime _date = DateTime.parse(date);
  DateTime _weekStart = DateTime.now().subtract(Duration(days: 7));
  return _date.compareTo(_weekStart) > 0;
}
