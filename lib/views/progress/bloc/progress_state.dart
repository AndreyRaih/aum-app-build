abstract class ProgressState {
  const ProgressState();
}

class ProgressIsLoading extends ProgressState {
  const ProgressIsLoading();
}

class ProgressByWeek extends ProgressState {
  final List<SessionData> sessions;
  final List<AsanaNote> notes;
  const ProgressByWeek({this.sessions = const [], this.notes = const []});

  List<double> get bars {
    List<double> _days = [0, 0, 0, 0, 0, 0, 0];
    List _activeDays =
        this.sessions.map((session) => {"time": session.duration, "day": _findWeekDate(session.date)}).toList();
    _activeDays.forEach((day) {
      double percentage = (day["time"] / 3600) * 100;
      int index = 6 - (day["day"] - 1);
      _days[index] = percentage;
    });
    return _days;
  }

  String get caloriesTotal =>
      sessions.length > 0 ? sessions.map((item) => item.cal).reduce((total, value) => total + value).toString() : '0';

  String get totalTime => sessions.length > 0
      ? _formatTime(Duration(seconds: sessions.map((item) => item.duration).reduce((total, value) => total + value)))
      : '00:00:00';
}

class SessionData {
  final DateTime date;
  final int cal;
  final int duration;

  SessionData(this.date, this.cal, this.duration);

  SessionData.fromJson(Map json)
      : this.date = DateTime.parse(json["date"]),
        this.cal = json["cal"],
        this.duration = json["duration"];
}

class AsanaNote {
  final String name;
  final List<String> notes;

  AsanaNote(this.name, this.notes);

  AsanaNote.fromJson(Map json)
      : this.name = json["name"],
        this.notes = json["notes"];
}

dynamic _findWeekDate(DateTime date) {
  DateTime _weekStart = DateTime.now().subtract(Duration(days: 7));
  int diff = date.difference(_weekStart).inDays;
  return diff > 0 ? 7 - diff : -1;
}

String _formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}
