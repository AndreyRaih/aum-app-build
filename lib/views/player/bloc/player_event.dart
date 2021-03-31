import 'package:aum_app_build/data/models/practice.dart';

abstract class PlayerEvent {
  const PlayerEvent();
}

class GetPlayerQueue extends PlayerEvent {
  final AumPracticePlayerData playerData;
  const GetPlayerQueue(this.playerData);

  List<String> get blocks => ["balances_1"]; // playerData.practice.userQueue;
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
