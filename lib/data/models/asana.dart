import 'package:aum_app_build/data/models/preferences.dart';
import 'package:flutter/material.dart';

enum AsanaAudioVoice { male, female }

class AsanaItem {
  String id;
  String name;
  String block;
  String src;
  int level;
  List<AsanaAudio> audioSources;
  bool isCheck;
  Duration captureTime;

  AsanaItem(this.id, this.name, this.block, this.src, this.level, this.isCheck, this.captureTime,
      {this.audioSources = const []});

  AsanaItem.fromJson(Map json)
      : id = json["id"],
        name = json["name"],
        block = json["block"],
        src = json["src"],
        level = json["level"],
        isCheck = json["isCheck"],
        captureTime = json["captureTime"] != null ? Duration(seconds: json["captureTime"]) : null,
        audioSources = json["audioSources"].map<AsanaAudio>((element) => AsanaAudio.fromJson(element)).toList();

  static AsanaMediaFragment convertToVideoFragment(
      AsanaItem asana, PracticePreferences preferences, String displayingName) {
    String _getAudioByPreferences(List<AsanaAudio> audio, PracticePreferences preferences) => audio
        .firstWhere((_audio) => (_audio.isShort == preferences.complexity) && (_audio.voice == preferences.voice))
        ?.src;
    if (asana.src != null && asana.audioSources.length > 0) {
      String _video = asana.src;
      String _audio = _getAudioByPreferences(asana.audioSources, preferences);
      return AsanaMediaFragment(videoSrc: _video, audioSrc: _audio, displayingName: displayingName);
    } else {
      return null;
    }
  }
}

class AsanaAudio {
  String src;
  AsanaAudioVoice voice;
  bool isShort;

  AsanaAudio(this.src, this.voice, this.isShort);

  AsanaAudio.fromJson(Map json)
      : src = json["src"],
        voice = json["voice"] == "female" ? AsanaAudioVoice.female : AsanaAudioVoice.male,
        isShort = json["isShort"];
}

class AsanaMediaFragment {
  String displayingName;
  String videoSrc;
  String audioSrc;

  AsanaMediaFragment({@required this.videoSrc, @required this.audioSrc, this.displayingName});
}
