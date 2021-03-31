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

  const PlayerLoadSuccess({this.asana, this.asanaQueue, this.preferences});

  String get asanaFormattedName => (asana.name[0].toUpperCase() + asana.name.substring(1)).replaceAll('_', ' ');
  int get asanaPosition => asanaQueue != null ? (asanaQueue.indexWhere((element) => asana.id == element.id) + 1) : 0;
  AsanaMediaFragment get asanaVideoFragment => asana != null && preferences != null
      ? AsanaItem.convertToVideoFragment(asana, preferences, this.asanaFormattedName)
      : null;
  int get queueLength => asanaQueue.length;
}

class PlayerLoadFailure extends PlayerState {}
