import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/data/models/preferences.dart';

abstract class PlayerState {
  const PlayerState();
}

class PlayerInitial extends PlayerState {}

class PlayerLoadInProgress extends PlayerState {}

class PlayerLoadSuccess extends PlayerState {
  final PracticePreferences preferences;
  final List<AsanaItem> asanaQueue;
  final AsanaItem asana;
  final bool isOnlyCheck;
  final bool isSingle;

  const PlayerLoadSuccess(
      {this.asana, this.asanaQueue, this.preferences, this.isOnlyCheck = false, this.isSingle = false});

  List<Object> get props => [asana, asanaQueue];

  int get asanaPosition => asanaQueue != null ? asanaQueue.indexWhere((element) => asana.id == element.id) : 0;
  AsanaVideoFragment get asanaVideoFragment =>
      asana != null && preferences != null ? AsanaItem.convertToVideoFragment(asana, preferences) : null;
}

class PlayerLoadFailure extends PlayerState {}
