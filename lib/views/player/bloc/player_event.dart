import 'package:flutter/material.dart';

abstract class PlayerEvent {
  const PlayerEvent();
}

class GetPlayerQueue extends PlayerEvent {
  const GetPlayerQueue();
}

class GetPlayerNextPart extends PlayerEvent {
  const GetPlayerNextPart();
}

class GetPlayerPreviousPart extends PlayerEvent {
  const GetPlayerPreviousPart();
}

class GetPlayerExitTo extends PlayerEvent {
  final String routeName;
  const GetPlayerExitTo({@required this.routeName});
}
