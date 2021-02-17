import 'package:aum_app_build/utils/data.dart';
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
    DataExtractor utils = DataExtractor(data);
    this.name = utils.getValue("name");
    this.description = utils.getValue("description");
    this.accents = utils.getValue("accents");
    this.time = utils.getValue("time");
    this.cal = utils.getValue("cal");
    this.benefits = utils.getValue("benefits");
    this.blocks = utils.getValue("blocks");
    this.userQueue = utils.getValue("userQueue");
    this.img = NetworkImage(
        'https://images.unsplash.com/photo-1593810451137-5dc55105dace?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=2852&q=80'); // utils.fromData("descriptionImg") == null ? AssetImage(MAIN_BACKGROUND_IMAGE) : NetworkImage(utils.fromData("descriptionImg"));
  }
}
