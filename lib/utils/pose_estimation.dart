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

  List<PosePoint> buildKeypoints(Map pose, CameraImage image, Size screen) {
    if (pose == null) return [];
    if (image == null) return [];

    return pose["keypoints"].values.map<PosePoint>((_k) {
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

      return PosePoint(_k);
    }).toList();
  }

  Future<List<PosePoint>> estimate(CameraImage img, {Size screen}) async {
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
}

class PosePoint {
  double score = 0;
  double x = 0;
  double y = 0;
  String part;

  PosePoint(Map source) {
    this.score = source["score"];
    this.x = source["x"];
    this.y = source["y"];
    this.part = source["part"];
  }
}
