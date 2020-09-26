import 'package:aum_app_build/data/models/asana.dart';
import 'package:flutter/material.dart';

abstract class PlayerState {
  const PlayerState();
}

class PlayerInitial extends PlayerState {}

class PlayerLoadInProgress extends PlayerState {}

class PlayerLoadSuccess extends PlayerState {
  final List<AsanaVideoPart> asanaQueue;
  final AsanaVideoPart asana;

  const PlayerLoadSuccess({this.asana, this.asanaQueue});

  @override
  List<Object> get props => [asana, asanaQueue];

  @override
  int get asanaPosition => asanaQueue != null
      ? asanaQueue.indexWhere((element) => asana.url == element.url)
      : 0;
}

class PlayerLoadFailure extends PlayerState {}

class PlayerExitState extends PlayerState {
  final String routeName;
  const PlayerExitState({@required this.routeName});
}
