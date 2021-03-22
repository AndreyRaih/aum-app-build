import 'dart:async';

import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/models/asana.dart';
import 'package:aum_app_build/utils/pose_estimation.dart';
import 'package:aum_app_build/views/player/bloc/pose_estimation/estimation_event.dart';
import 'package:aum_app_build/views/player/bloc/pose_estimation/estimation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const int MAX_PERCENTAGE = 150;
const int MIN_PERCENTAGE = 50;

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
    bool _pointsIsExist = event.rawPoints.length > 0;
    print('points validation: exist = $_pointsIsExist');
    if (_pointsIsExist) {
      bool _isPointsValid =
          state is EstimationActive ? _checkPointsUpdates((state as EstimationActive).points, event.points) : true;
      print('points validation: valid = $_isPointsValid');
      if (_isPointsValid) {
        List<AsanaEstimationResultItem> _result = _analyser.processedEntitiesByRules(event.points, event.asana.rules);
        List<PoseEstimateEntity> _markedPoints = _adjustPointsByResult(event.points, _result);
        _onAsanaStateChange(event.asana, _result);
        print('points added: $_markedPoints');
        yield EstimationActive(_markedPoints);
      }
    }
  }

  bool _checkPointsUpdates(List<PoseEstimateEntity> oldPoints, List<PoseEstimateEntity> newPoints) {
    List<PointDifference> _listOfPositionDifferences = newPoints.map((_point) {
      PoseEstimateEntity _prevPoint = oldPoints.firstWhere((element) => element.part == _point.part);
      double _diffX = _point.x / (_prevPoint.x / 100);
      double _diffY = _point.y / (_prevPoint.y / 100);
      print('DIFF PRECESS: part - ${_point.part} with diffs - x: $_diffX; y: $_diffY');
      return PointDifference(_diffX, _diffY);
    }).toList();
    List<double> _listOfScores = newPoints.map((_point) => _point.score).toList();
    bool _isPositionDifferencesTrigger = _listOfPositionDifferences
            .where((el) =>
                (el.x > MIN_PERCENTAGE || el.x < MAX_PERCENTAGE) && (el.y > MIN_PERCENTAGE || el.y < MAX_PERCENTAGE))
            .toList()
            .length >
        _listOfPositionDifferences.length / 2;
    bool _isScoresTrigger = _listOfScores.where((el) => el > 0.3).toList().length > _listOfScores.length / 2;
    print(
        'CHEKING: Diffs - ${_listOfPositionDifferences.map((el) => el.toString()).toList()}; Scores - $_listOfScores');
    print('CHECKING RESULT: diff - $_isPositionDifferencesTrigger, scores - $_isScoresTrigger');
    return _isPositionDifferencesTrigger && _isScoresTrigger;
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

class PointDifference {
  double x = 0;
  double y = 0;
  PointDifference(x, y);

  String toString() => 'x: $x ; y: $y';
}
