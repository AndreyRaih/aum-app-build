import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';

class AumAudio {
  final String uri;
  AudioPlayer player;

  AumAudio({@required this.uri}) {
    player = AudioPlayer();
  }

  void play() async {
    await player.play(uri);
  }

  void stop() async {
    await player.stop();
  }
}
