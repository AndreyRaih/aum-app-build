import 'dart:io';
import 'package:aum_app_build/utils/data.dart';
import 'package:flutter/material.dart';

class AumUser {
  String id;
  String name;
  Map levels;
  List recentResults;
  List sessions;
  Map onboardingComplete;

  AumUser(data) {
    DataUtils utils = DataUtils(data);
    this.id = utils.fromData("id");
    this.name = utils.fromData("name");
    this.levels = utils.fromData("levels");
    this.recentResults = utils.fromData("recentResults");
    this.sessions = utils.fromData("sessions");
    this.onboardingComplete = utils.fromData("onboardingComplete");
  }
}

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
    DataUtils utils = DataUtils(data);
    this.name = utils.fromData("name");
    this.description = utils.fromData("description");
    this.accents = utils.fromData("accents");
    this.time = utils.fromData("time");
    this.cal = utils.fromData("cal");
    this.benefits = utils.fromData("benefits");
    this.blocks = utils.fromData("blocks");
    this.userQueue = utils.fromData("userQueue");
    this.img = NetworkImage(
        'https://images.unsplash.com/photo-1593810451137-5dc55105dace?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=2852&q=80'); // utils.fromData("descriptionImg") == null ? AssetImage(MAIN_BACKGROUND_IMAGE) : NetworkImage(utils.fromData("descriptionImg"));
  }
}

class NewUserDataModel {
  final String email;
  final String password;
  final String name;
  final File avatar;
  const NewUserDataModel({@required this.email, @required this.password, this.name, this.avatar});
}
