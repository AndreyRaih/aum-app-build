class AumUser {
  dynamic name;
  Map levels;
  List recentResults;
  List sessions;
  bool hasIntroduction;

  AumUser(data) {
    dynamic fromData(String key, {dynamic defaultValue}) =>
        data[key] != null ? data[key] : defaultValue;
    this.name = fromData("name");
    this.levels = fromData("levels");
    this.recentResults = fromData("recentResults");
    this.sessions = fromData("sessions");
    this.hasIntroduction = fromData("hasIntroduction", defaultValue: false);
  }
}
