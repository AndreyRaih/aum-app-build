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
    var utils = DataUtils(data);
    this.id = utils.fromData("id");
    this.name = utils.fromData("name");
    this.levels = utils.fromData("levels");
    this.recentResults = utils.fromData("recentResults");
    this.sessions = utils.fromData("sessions");
    this.onboardingComplete = utils.fromData("onboardingComplete");
  }
}

class NewUserDataModel {
  final String email;
  final String password;
  final String name;
  final File avatar;
  const NewUserDataModel({@required this.email, @required this.password, this.name, this.avatar});
}
