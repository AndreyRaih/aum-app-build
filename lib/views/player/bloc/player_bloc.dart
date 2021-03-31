import 'dart:async';
import 'package:aum_app_build/common_bloc/navigator/navigator_cubit.dart';
import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/data/content_repository.dart';
import 'package:aum_app_build/views/player/bloc/player_event.dart';
import 'package:aum_app_build/views/player/bloc/player_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  ContentRepository repository = ContentRepository();
  final NavigatorCubit navigation;

  PlayerBloc({this.navigation}) : super(PlayerLoadInProgress());

  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async* {
    if (event is GetPlayerQueue) {
      yield* _mapPlayerGetQueueToState(event);
    } else if (event is GetPlayerNextPart) {
      yield* _mapPlayerGetNextPartToState();
    } else if (event is GetPlayerPreviousPart) {
      yield* _mapPlayerGetPreviousPartToState();
    } else if (event is PlayerExit) {
      yield* _mapPlayerExitToState(event);
    }
  }

  Stream<PlayerState> _mapPlayerGetQueueToState(GetPlayerQueue event) async* {
    try {
      List<AsanaItem> queue = await this.repository.getQueue(event.blocks);
      yield PlayerLoadSuccess(asanaQueue: queue, asana: queue[0], preferences: event.playerData.preferences);
    } catch (err) {
      print(err);
      yield PlayerLoadFailure();
    }
  }

  Stream<PlayerState> _mapPlayerGetNextPartToState() async* {
    if (state is PlayerLoadSuccess) {
      final AsanaItem next = _getNextVideoPart(state as PlayerLoadSuccess);
      if (next == null) {
        this.add(PlayerExit(routeName: '/feedback', arguments: (state as PlayerLoadSuccess).asanaQueue));
      } else {
        yield PlayerLoadSuccess(
          preferences: (state as PlayerLoadSuccess).preferences,
          asanaQueue: (state as PlayerLoadSuccess).asanaQueue,
          asana: next,
        );
      }
    }
  }

  Stream<PlayerState> _mapPlayerGetPreviousPartToState() async* {
    if (state is PlayerLoadSuccess) {
      final AsanaItem prevoius = _getPreviousVideoPart(state as PlayerLoadSuccess);
      if (prevoius == null) {
        this.add(PlayerExit());
      } else {
        yield PlayerLoadSuccess(
          preferences: (state as PlayerLoadSuccess).preferences,
          asanaQueue: (state as PlayerLoadSuccess).asanaQueue,
          asana: prevoius,
        );
      }
    }
  }

  Stream<PlayerState> _mapPlayerExitToState(PlayerExit event) async* {
    if (event.routeName != null) {
      navigation.navigatorPush(event.routeName, arguments: event.arguments);
    } else {
      navigation.navigatorPop();
    }
  }

  AsanaItem _getNextVideoPart(PlayerLoadSuccess state) {
    int _nextPosition = state.asanaPosition + 1;
    return _nextPosition < state.asanaQueue.length ? state.asanaQueue[_nextPosition] : null;
  }

  AsanaItem _getPreviousVideoPart(PlayerLoadSuccess state) {
    int _previousPosition = state.asanaPosition - 1;
    return _previousPosition >= 0 ? state.asanaQueue[_previousPosition] : null;
  }
}
