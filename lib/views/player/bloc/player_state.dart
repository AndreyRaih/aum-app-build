import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/data/models/video.dart';
import 'package:aum_app_build/views/practice_preview/components/preferences.dart';
import 'package:flutter/material.dart';

abstract class PlayerState {
  const PlayerState();
}

class PlayerInitial extends PlayerState {}

class PlayerLoadInProgress extends PlayerState {}

class PlayerLoadSuccess extends PlayerState {
  final PracticePreferences preferences;
  final List<VideoPart> asanaQueue;
  final VideoPart asana;
  final bool isOnlyCheck;
  final bool isSingle;

  const PlayerLoadSuccess({this.asana, this.asanaQueue, this.preferences, this.isOnlyCheck = false, this.isSingle = false});

  List<Object> get props => [asana, asanaQueue];

  int get asanaPosition => asanaQueue != null ? asanaQueue.indexWhere((element) => asana.id == element.id) : 0;
}

class PlayerLoadFailure extends PlayerState {}
