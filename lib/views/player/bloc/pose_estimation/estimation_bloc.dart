import 'dart:async';

import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/utils/pose_estimation.dart';
import 'package:aum_app_build/views/player/bloc/pose_estimation/estimation_event.dart';
import 'package:aum_app_build/views/player/bloc/pose_estimation/estimation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EstimationBloc extends Bloc<EstimationBlocEvent, EstimationBlocState> {
  final UserBloc userBloc;
  PoseAnalyser _analyser = PoseAnalyser();
  Timer _handleAsanaEstimationTimer;
  EstimationBloc({@required this.userBloc}) : super(EstimationAwait());

  @override
  Stream<EstimationBlocState> mapEventToState(EstimationBlocEvent event) async* {
    if (event is EstimationCreatePointsEvent) {
      yield* _mapCreatePointEventToState(event);
    }
  }

  Stream<EstimationBlocState> _mapCreatePointEventToState(EstimationCreatePointsEvent event) async* {
    if (event.points.length > 0) {
      List<AsanaEstimationResultItem> _result = _analyser.processedEntitiesByRules(event.points, event.asana.rules);
      List<PoseEstimateEntity> _markedPoints = _adjustPointsByResult(event.points, _result);
      _onAsanaStateChange(event.asana, _result);
      yield EstimationActive(_markedPoints);
    } else {
      yield EstimationAwait();
    }
  }

  List<PoseEstimateEntity> _adjustPointsByResult(
      List<PoseEstimateEntity> basePoints, List<AsanaEstimationResultItem> resultItems) {
    basePoints.forEach((_point) {
      AsanaEstimationResultItem _relatedItem = resultItems.firstWhere(
          (_resultItem) => _resultItem.chain.toLowerCase().contains(_point.part.toLowerCase()),
          orElse: () => null);
      if (_relatedItem != null) {
        _point.isActive = _relatedItem.isDone;
      }
    });
    return basePoints.where((_point) => _point.x > 0 && _point.y > 0).toList();
  }

  void _onAsanaStateChange(AsanaItem asana, List<AsanaEstimationResultItem> result) {
    bool _trigger = result.every((element) => element.isDone);
    _handleAsanaObserverState(_trigger, asana, result);
  }

  void _handleAsanaObserverState(bool trigger, AsanaItem asana, List<AsanaEstimationResultItem> results) {
    if (_handleAsanaEstimationTimer == null && trigger) {
      _handleAsanaEstimationTimer = Timer.periodic(Duration(seconds: 3), (timer) {
        _handleSuccessAsana(asana, results);
        timer.cancel();
      });
    } else if (_handleAsanaEstimationTimer != null && !trigger) {
      _handleAsanaEstimationTimer.cancel();
      _handleAsanaEstimationTimer = null;
    }
  }

  void _handleSuccessAsana(AsanaItem asana, List<AsanaEstimationResultItem> results) {
    AsanaEstimationResult _result = AsanaEstimationResult(asana.name, asana.block, results);
    userBloc.add(SetUserAsanaResult(_result));
  }
}
