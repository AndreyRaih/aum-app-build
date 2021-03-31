import 'package:aum_app_build/data/models/preferences.dart';
import 'package:flutter/material.dart';

class AumUserPractice {
  String name;
  String description;
  List accents;
  int time;
  int cal;
  List benefits;
  List blocks;
  List userQueue;
  bool isMain;
  ImageProvider img;

  AumUserPractice(Map data) {
    name = data["name"];
    description = data["description"];
    accents = data["accents"];
    time = data["time"];
    cal = data["cal"];
    benefits = data["benefits"];
    blocks = data["blocks"];
    userQueue = data["userQueue"];
    isMain = data["isMain"];
    img = data["descriptionImg"] != null ? NetworkImage(data["descriptionImg"]) : null;
  }
}

class AumPracticePlayerData {
  final AumUserPractice practice;
  PracticePreferences preferences = PracticePreferences();

  AumPracticePlayerData(this.practice, {this.preferences});
}
