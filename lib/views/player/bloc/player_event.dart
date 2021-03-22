import 'package:aum_app_build/data/models/preferences.dart';
import 'package:flutter/material.dart';

abstract class PlayerEvent {
  const PlayerEvent();
}

class GetPlayerQueue extends PlayerEvent {
  final PracticePreferences preferences;
  final List blocks;
  const GetPlayerQueue({this.preferences, @required this.blocks});
}

class GetPlayerNextPart extends PlayerEvent {
  const GetPlayerNextPart();
}

class GetPlayerPreviousPart extends PlayerEvent {
  const GetPlayerPreviousPart();
}

class PlayerExit extends PlayerEvent {
  final String routeName;
  final dynamic arguments;
  const PlayerExit({this.routeName, this.arguments});
}
