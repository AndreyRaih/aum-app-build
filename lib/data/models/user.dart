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
  }
}

class NewUserDataModel {
  final String email;
  final String password;
  final String name;
  final File avatar;
  const NewUserDataModel({@required this.email, @required this.password, this.name, this.avatar});
}
