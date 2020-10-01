import 'package:flutter/material.dart';

class AsanaVideoPart {
  String url;
  String name;
  double duration;
  double timerStartPosition;
  bool isCheck;
  String audio;
  AsanaVideoPart(
      {@required this.url,
      @required this.name,
      this.duration,
      this.timerStartPosition,
      this.audio,
      this.isCheck = false});
}
