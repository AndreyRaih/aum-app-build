import 'dart:io';
import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/utils/data.dart';
import 'package:flutter/material.dart';

class AumUser {
  String id;
  String name;
  AumUserLevels levels;
  List<AumUserRecentResult> recentResults;
  List<AumUserSession> sessions;
  AumUserOnboarding onboardingComplete;

  AumUser(id, name, levels, onboardingComplete, {this.recentResults = const [], this.sessions = const []});

  factory AumUser.fromJson(Map json) {
    DataExtractor _source = DataExtractor(json);
    return AumUser(_source.getValue("id"), _source.getValue("name"), _source.getValue("levels"),
        _source.getValue("onboardingComplete"),
        recentResults: _source.getValue("recentResults"), sessions: _source.getValue("sessions"));
  }
}

class AumUserLevels {
  int standing;
  int sitting;
  int balances;
  int lyingForward;
  int lyingBack;

  AumUserLevels({this.standing, this.sitting, this.balances, this.lyingForward, this.lyingBack});

  factory AumUserLevels.fromJson(Map json) {
    DataExtractor _source = DataExtractor(json);
    return AumUserLevels(
        standing: _source.getValue("standing"),
        sitting: _source.getValue("sitting"),
        balances: _source.getValue("balances"),
        lyingForward: _source.getValue("lying_forward"),
        lyingBack: _source.getValue("lying_back"));
  }
}

class AumUserRecentResult {
  String asana;
  String block;
  List<AsanaEstimationEntity> doneEntries;
  List<AsanaEstimationEntity> failures;

  AumUserRecentResult(asana, block, {this.doneEntries = const [], this.failures = const []});

  factory AumUserRecentResult.fromJson(Map json) {
    DataExtractor _source = DataExtractor(json);
    return AumUserRecentResult(_source.getValue("asana"), _source.getValue("block"),
        doneEntries: _source.getValue("doneEntries"), failures: _source.getValue("failures"));
  }
}

class AumUserSession {
  String id;
  int userRange;
  int asanaQuantity;
  String date;
  int duration;
  int cal;

  AumUserSession(id, {this.userRange = 0, this.asanaQuantity = 0, this.date, this.duration, this.cal});

  factory AumUserSession.fromJson(Map json) {
    DataExtractor _source = DataExtractor(json);
    return AumUserSession(_source.getValue("id"),
        userRange: _source.getValue("userRange"),
        asanaQuantity: _source.getValue("asanaQuantity"),
        date: _source.getValue("date"),
        duration: _source.getValue("duration"),
        cal: _source.getValue("cal"));
  }
}

class AumUserOnboarding {
  bool concept;
  bool player;

  AumUserOnboarding({this.concept, this.player});

  factory AumUserOnboarding.fromJson(Map json) {
    DataExtractor _source = DataExtractor(json);
    return AumUserOnboarding(concept: _source.getValue("concept"), player: _source.getValue("player"));
  }
}

class AumUserCreateModel {
  final String email;
  final String password;
  final String name;
  final File avatar;

  AumUserCreateModel({@required this.email, @required this.password, this.name, this.avatar});
}
