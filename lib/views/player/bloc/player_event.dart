import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/practice_preview/components/preferences.dart';
import 'package:flutter/material.dart';

abstract class PlayerEvent {
  const PlayerEvent();
}

class GetPlayerQueue extends PlayerEvent {
  final PracticePreferences preferences;
  const GetPlayerQueue({this.preferences});
}

class GetPlayerCheckQueue extends PlayerEvent {
  final PracticePreferences preferences;
  const GetPlayerCheckQueue({this.preferences});
}

class GetPlayerAsana extends PlayerEvent {
  final String id;
  const GetPlayerAsana({this.id});
}

class GetPlayerNextPart extends PlayerEvent {
  const GetPlayerNextPart();
}

class GetPlayerPreviousPart extends PlayerEvent {
  const GetPlayerPreviousPart();
}

class PlayerExit extends PlayerEvent {
  const PlayerExit();
}
