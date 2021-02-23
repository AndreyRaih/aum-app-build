import 'dart:math';

import 'package:aum_app_build/data/models/asana.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class PoseAnalyser {
  final bool debug;
  bool isReady = false;
  PoseAnalyser({this.debug = false});

  Future loadModel() async {
    print('load init');
    try {
      print('load start');
      await Tflite.loadModel(model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
      isReady = true;
      print('load end');
    } catch (err) {
      print(err);
    }
  }

  List<PoseEstimateEntity> buildKeypoints(Map pose, CameraImage image, Size screen) {
    if (pose == null) return [];
    if (image == null) return [];

    return pose["keypoints"].values.map<PoseEstimateEntity>((_k) {
      if (debug) {
        print('part: ${_k["part"]}');
        print('basic: x - ${_k["x"]}; y - ${_k["y"]};');
      }
      double screenW = screen.width;
      double screenH = screen.height;
      int previewW = image.width;
      int previewH = image.height;
      double scaleW = screenH / previewH * previewW;
      double scaleH = screenH;
      double difW = (scaleW - screenW) / scaleW;
      _k["x"] = (_k["x"] - difW / 2) * scaleW;
      _k["y"] = _k["y"] * scaleH;
      if (debug) {
        print('screen: w - $screenW; h - $screenH;');
        print('preview: w - $previewW; h - $previewH;');
        print('scales: w - $scaleW; h - $scaleH;');
        print('difW: $difW;');
        print('transform: x - ${_k["x"]}; y - ${_k["y"]};');
      }

      return PoseEstimateEntity(_k);
    }).toList();
  }

  Future<List<PoseEstimateEntity>> estimate(CameraImage img, {Size screen}) async {
    if (!isReady) {
      return throw ("Tflite model is not ready.");
    }
    return Tflite.runPoseNetOnFrame(
      bytesList: img.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      imageHeight: img.height,
      imageWidth: img.width,
      numResults: 1,
    ).then((raw) => raw.length > 0 ? buildKeypoints(raw[0], img, screen) : []);
  }

  List<AsanaEstimationResultItem> processedEntitiesByRules(List<PoseEstimateEntity> entities, List<AsanaRule> rules) {
    List<AsanaEstimationResultItem> _result = [];
    rules.forEach((_rule) {
      AsanaEstimationResultItem _processedEntities = _figureOutPointsByRule(_rule, entities);
      _result..add(_processedEntities);
    });
    return _result.toList();
  }

  AsanaEstimationResultItem _figureOutPointsByRule(AsanaRule rule, List<PoseEstimateEntity> entities) {
    List<PoseEstimateEntity> _linePoints = rule.line
        .map((_part) => entities.firstWhere((element) => element.part.toLowerCase().contains(_part.toLowerCase())))
        .toList();
    double _angleRad = _findAngle(_linePoints[0], _linePoints[1], _linePoints[2]);
    double _angleDeg = (_angleRad * (180 / pi))..round();
    int _offsetMax = rule.angle + (rule.offset.max != null ? rule.offset.max : 10);
    int _offsetMin = rule.angle - (rule.offset.min != null ? rule.offset.min : 10);
    bool _isDone = _angleDeg <= _offsetMax && _angleDeg >= _offsetMin;
    // print('line: ${rule.line}, deg: $_angleDeg, done: $_isDone');
    _linePoints.forEach((_element) => _element.isActive = _isDone);
    return AsanaEstimationResultItem(rule.line.join(', '), _angleDeg, isDone: _isDone);
  }

  double _findAngle(PoseEstimateEntity a, PoseEstimateEntity b, PoseEstimateEntity c) {
    var ab = sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2));
    var bc = sqrt(pow(b.x - c.x, 2) + pow(b.y - c.y, 2));
    var ac = sqrt(pow(c.x - a.x, 2) + pow(c.y - a.y, 2));
    return acos((bc * bc + ab * ab - ac * ac) / (2 * bc * ab));
  }
}

class PoseEstimateEntity {
  double score = 0;
  double x = 0;
  double y = 0;
  String part;
  bool isActive = false;

  PoseEstimateEntity(Map source) {
    this.score = source["score"];
    this.x = source["x"];
    this.y = source["y"];
    this.part = source["part"];
    this.isActive = source["isActive"] != null ? source["isActive"] : false;
  }
}
