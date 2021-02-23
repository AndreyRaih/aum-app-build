import 'dart:io';
import 'package:aum_app_build/data/models/asana.dart';
import 'package:flutter/material.dart';

class AumUser {
  String id;
  String name;
  AumUserLevels levels;
  List<AumUserRecentResult> recentResults;
  List<AumUserSession> sessions;
  AumUserOnboarding onboardingComplete;

  AumUser(id, name, levels, onboardingComplete, {this.recentResults = const [], this.sessions = const []});

  AumUser.fromJson(Map json)
      : id = json["id"],
        name = json["name"],
        levels = AumUserLevels.fromJson(json["levels"]),
        onboardingComplete = AumUserOnboarding.fromJson(json["onboardingComplete"]),
        recentResults =
            json["recentResults"].map<AumUserRecentResult>((element) => AumUserRecentResult.fromJson(element)).toList(),
        sessions = json["sessions"].map<AumUserSession>((element) => AumUserSession.fromJson(element)).toList();
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

class AumUserRecentResult {
  String asana;
  String block;
  List<AsanaEstimationResultItem> doneEntries;
  List<AsanaEstimationResultItem> failures;

  AumUserRecentResult(asana, block, {this.doneEntries = const [], this.failures = const []});

  AumUserRecentResult.fromJson(Map json)
      : asana = json["asana"],
        block = json["block"],
        this.doneEntries = json["doneEntries"]
            .map<AsanaEstimationResultItem>(
                (_entry) => AsanaEstimationResultItem(_entry["chain"], _entry["deg"], isDone: _entry["isDone"]))
            .toList(),
        this.failures = json["failures"]
            .map<AsanaEstimationResultItem>(
                (_entry) => AsanaEstimationResultItem(_entry["chain"], _entry["deg"], isDone: _entry["isDone"]))
            .toList();
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

class AumUserCreateModel {
  final String email;
  final String password;
  final String name;
  final File avatar;

  AumUserCreateModel({@required this.email, @required this.password, this.name, this.avatar});
}
