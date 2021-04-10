import 'dart:io';
import 'package:aum_app_build/data/constants.dart';
import 'package:flutter/material.dart';

class AumUser {
  String id;
  String name;
  String avatar;
  AumUserLevels levels;
  AumUserOnboarding onboardingComplete;

  AumUser(
      {@required this.id,
      @required this.name,
      this.avatar = DEFAULT_AVATAR_IMG,
      @required this.levels,
      this.onboardingComplete});

  AumUser.fromJson(Map json)
      : this.id = json["id"],
        this.name = json["name"],
        this.avatar = json["avatar"] != null ? json["avatar"] : DEFAULT_AVATAR_IMG,
        this.levels = AumUserLevels.fromJson(json["levels"]),
        this.onboardingComplete = AumUserOnboarding.fromJson(json["onboardingComplete"]);
}

class AumUserLevels {
  int standing;
  int sitting;
  int balances;
  int lyingForward;
  int lyingBack;

  AumUserLevels({this.standing, this.sitting, this.balances, this.lyingForward, this.lyingBack});

  AumUserLevels.fromJson(Map json)
      : this.standing = json["standing"],
        this.sitting = json["sitting"],
        this.balances = json["balances"],
        this.lyingForward = json["lying_forward"],
        this.lyingBack = json["lying_back"];
}

class AumUserReslutHistoryItem {
  String asana;
  String block;
  List<String> history;

  AumUserReslutHistoryItem(asana, block, {this.history = const []});

  AumUserReslutHistoryItem.fromJson(Map json)
      : asana = json["asana"],
        block = json["block"],
        this.history = json["history"];
}

class AumUserSession {
  String id;
  int userRange;
  int asanaQuantity;
  String date;
  int duration;
  int cal;

  AumUserSession(id, {this.userRange = 0, this.asanaQuantity = 0, this.date, this.duration, this.cal});

  AumUserSession.fromJson(Map json)
      : id = json["id"],
        this.userRange = json["userRange"],
        this.asanaQuantity = json["asanaQuantity"],
        this.date = json["date"],
        this.duration = json["duration"],
        this.cal = json["cal"];
}

class AumUserOnboarding {
  bool concept;
  bool player;

  AumUserOnboarding({this.concept, this.player});

  AumUserOnboarding.fromJson(Map json)
      : this.concept = json["concept"],
        this.player = json["player"];
}

class AumUserUpdatesModel {
  final File avatar;
  final String name;
  final List<String> interests;

  AumUserUpdatesModel({@required this.name, this.avatar, this.interests});
}
