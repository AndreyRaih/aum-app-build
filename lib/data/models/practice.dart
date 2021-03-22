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
    img = data["descriptionImg"] != null ? NetworkImage(data["descriptionImg"]) : null;
  }
}
