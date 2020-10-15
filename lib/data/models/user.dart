class AumUser {
  String name;
  String sex;
  int ageGroup;
  double weight;
  int totalLevel;
  Map<String, num> levels;
  List<Map<DateTime, dynamic>> recentResults;
  List<Map<DateTime, String>> sessions;
  void fromJson(json) {
    this.name = json["name"];
    this.sex = json["sex"];
    this.ageGroup = json["ageGroup"];
    this.weight = json["weight"];
    this.totalLevel = json["totalLevel"];
    this.levels = json["levels"];
    this.recentResults = json["recent_results"];
    this.sessions = json["sessions"];
  }
}
