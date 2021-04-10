abstract class DetailsState {
  const DetailsState();
}

class DetailsIsLoading extends DetailsState {
  const DetailsIsLoading();
}

class DetailsSuccess extends DetailsState {
  final AsanaDetailItem details;
  const DetailsSuccess(this.details);
}

class AsanaDetailItem {
  String name;
  String img;
  DetailsDescription description;
  List<AsanaHistoryItem> log;

  AsanaDetailItem(this.name, this.img, this.description, this.log);

  AsanaDetailItem.fromJson(Map json)
      : this.name = json["name"],
        this.description = DetailsDescription.fromJson(json["description"]),
        this.log = json["log"].map((element) => AsanaHistoryItem.fromJson(element)).toList();
}

class DetailsDescription {
  String complexity;
  List<String> included;
  List<String> hotspots;

  DetailsDescription(this.complexity, this.included, this.hotspots);

  DetailsDescription.fromJson(Map json)
      : this.complexity = json["complexity"],
        this.included = json["included"],
        this.hotspots = json["hotspots"];

  List<Map<String, String>> get dictionary => [
        {"label": "Complexity", "value": this.complexity},
        {"label": "Included", "value": this.included.join(', ')},
        {"label": "Hotspots", "value": this.hotspots.join(', ')},
      ];
}

class AsanaHistoryItem {
  DateTime date;
  String note;
  String range;

  AsanaHistoryItem(this.date, this.note, this.range);

  AsanaHistoryItem.fromJson(Map json)
      : this.date = DateTime.parse(json["date"]),
        this.note = json["note"],
        this.range = json["range"];
}
