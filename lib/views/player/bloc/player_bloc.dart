import 'dart:async';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/data/models/video.dart';
import 'package:aum_app_build/data/content_repository.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/bloc/player_state.dart';
import 'package:bloc/bloc.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  ContentRepository repository = ContentRepository();
  PlayerBloc() : super(PlayerLoadInProgress());
  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async* {
    if (event is GetPlayerQueue) {
      yield* _mapPlayerGetQueueToState(event);
    } else if (event is GetPlayerNextPart) {
      yield* _mapPlayerGetNextPartToState();
    } else if (event is GetPlayerPreviousPart) {
      yield* _mapPlayerGetPreviousPartToState();
    } else if (event is PlayerExit) {
      yield PlayerExitState(routeName: '/dashboard');
    }
  }

  Stream<PlayerState> _mapPlayerGetQueueToState(GetPlayerQueue event) async* {
    try {
      final List<VideoPart> queue = await this
          .repository
          .getAsanaQueue()
          .then((list) => list.map((item) => VideoPart(item)).toList());
      yield PlayerLoadSuccess(
          asanaQueue: queue, asana: queue[0], preferences: event.preferences);
    } catch (_) {
      print(_);
      yield PlayerLoadFailure();
    }
  }

  Stream<PlayerState> _mapPlayerGetNextPartToState() async* {
    if (state is PlayerLoadSuccess) {
      final VideoPart next = _getNextVideoPart(state as PlayerLoadSuccess);
      if (next == null) {
        yield PlayerExitState(routeName: '/feedback');
      } else {
        yield PlayerLoadSuccess(
            preferences: (state as PlayerLoadSuccess).preferences,
            asanaQueue: (state as PlayerLoadSuccess).asanaQueue,
            asana: next);
      }
    }
  }

  Stream<PlayerState> _mapPlayerGetPreviousPartToState() async* {
    if (state is PlayerLoadSuccess) {
      final VideoPart prevoius =
          _getPreviousVideoPart(state as PlayerLoadSuccess);
      if (prevoius == null) {
        yield PlayerExitState(routeName: '/');
      } else {
        yield PlayerLoadSuccess(
            preferences: (state as PlayerLoadSuccess).preferences,
            asanaQueue: (state as PlayerLoadSuccess).asanaQueue,
            asana: prevoius);
      }
    }
  }

  VideoPart _getNextVideoPart(PlayerLoadSuccess state) {
    int _nextPosition = state.asanaPosition + 1;
    return _nextPosition < state.asanaQueue.length
        ? state.asanaQueue[_nextPosition]
        : null;
  }

  VideoPart _getPreviousVideoPart(PlayerLoadSuccess state) {
    int _previousPosition = state.asanaPosition - 1;
    return _previousPosition >= 0 ? state.asanaQueue[_previousPosition] : null;
  }
}
