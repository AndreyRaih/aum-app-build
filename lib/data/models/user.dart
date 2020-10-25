import 'dart:convert';

class AumUser {
  dynamic name;
  dynamic sex;
  int ageGroup;
  double weight;
  int totalLevel;
  Map levels;
  List recentResults;
  List sessions;
  AumUser(data) {
    this.name = data["name"];
    this.sex = data["sex"];
    this.ageGroup = data["ageGroup"];
    this.weight = data["weight"];
    this.totalLevel = data["totalLevel"];
    this.levels = data["levels"];
    this.recentResults = data["recentResults"];
    this.sessions = data["sessions"];
  }
}
