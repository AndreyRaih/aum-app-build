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
    } else if (event is GetPlayerCheckQueue) {
      yield* _mapPlayerGetCheckQueueToState(event);
    } else if (event is GetPlayerAsana) {
      yield* _mapPlayerGetAsanaToState(event);
    } else if (event is GetPlayerNextPart) {
      yield* _mapPlayerGetNextPartToState();
    } else if (event is GetPlayerPreviousPart) {
      yield* _mapPlayerGetPreviousPartToState();
    } else if (event is PlayerExit) {
      yield PlayerExitState();
    }
  }

  Stream<PlayerState> _mapPlayerGetQueueToState(GetPlayerQueue event) async* {
    try {
      List _rawQueue = await this.repository.getQueue().then((list) {
        List _result = [];
        List _values = list.map((elem) => elem["value"]).toList();
        List _notEmptyValues = _values.where((element) => element.length > 0).toList();
        _notEmptyValues.forEach((_part) => _result.addAll(_part));
        return _result;
      });
      final List<VideoPart> queue = _rawQueue.map((item) => VideoPart(item)).toList();
      yield PlayerLoadSuccess(asanaQueue: queue, asana: queue[0], preferences: event.preferences);
    } catch (err) {
      print(err);
      yield PlayerLoadFailure();
    }
  }

  Stream<PlayerState> _mapPlayerGetCheckQueueToState(GetPlayerCheckQueue event) async* {
    try {
      final List<VideoPart> queue = await this
          .repository
          .getQueue()
          .then((list) => list.map((item) => VideoPart(item)).where((element) => element.isCheck != null && element.isCheck).toList());

      yield PlayerLoadSuccess(asanaQueue: queue, asana: queue[0], preferences: event.preferences, isOnlyCheck: true);
    } catch (err) {
      print(err);
      yield PlayerLoadFailure();
    }
  }

  Stream<PlayerState> _mapPlayerGetAsanaToState(GetPlayerAsana event) async* {
    try {
      final List<VideoPart> queue =
          await this.repository.getQueue().then((list) => list.map((item) => VideoPart(item)).where((element) => element.name == event.id).toList());
      yield PlayerLoadSuccess(asanaQueue: queue, asana: queue[0], isSingle: true, preferences: PracticePreferences());
    } catch (err) {
      print(err);
      yield PlayerLoadFailure();
    }
  }

  Stream<PlayerState> _mapPlayerGetNextPartToState() async* {
    if (state is PlayerLoadSuccess) {
      final VideoPart next = _getNextVideoPart(state as PlayerLoadSuccess);
      if (next == null) {
        if ((state as PlayerLoadSuccess).isOnlyCheck) {
          yield PlayerExitState(routeName: '/dashboard');
        } else {
          yield PlayerExitState(routeName: '/feedback', arguments: (state as PlayerLoadSuccess).asanaQueue);
        }
      } else {
        yield PlayerLoadSuccess(
          preferences: (state as PlayerLoadSuccess).preferences,
          asanaQueue: (state as PlayerLoadSuccess).asanaQueue,
          isOnlyCheck: (state as PlayerLoadSuccess).isOnlyCheck,
          isSingle: (state as PlayerLoadSuccess).isSingle,
          asana: next,
        );
      }
    }
  }

  Stream<PlayerState> _mapPlayerGetPreviousPartToState() async* {
    if (state is PlayerLoadSuccess) {
      final VideoPart prevoius = _getPreviousVideoPart(state as PlayerLoadSuccess);
      if (prevoius == null) {
        yield PlayerExitState();
      } else {
        yield PlayerLoadSuccess(
          preferences: (state as PlayerLoadSuccess).preferences,
          asanaQueue: (state as PlayerLoadSuccess).asanaQueue,
          isOnlyCheck: (state as PlayerLoadSuccess).isOnlyCheck,
          isSingle: (state as PlayerLoadSuccess).isSingle,
          asana: prevoius,
        );
      }
    }
  }

  VideoPart _getNextVideoPart(PlayerLoadSuccess state) {
    int _nextPosition = state.asanaPosition + 1;
    return _nextPosition < state.asanaQueue.length ? state.asanaQueue[_nextPosition] : null;
  }

  VideoPart _getPreviousVideoPart(PlayerLoadSuccess state) {
    int _previousPosition = state.asanaPosition - 1;
    return _previousPosition >= 0 ? state.asanaQueue[_previousPosition] : null;
  }
}
