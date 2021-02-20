import 'package:aum_app_build/data/models/preferences.dart';
import 'package:flutter/material.dart';

class AsanaItem {
  String id;
  String name;
  String block;
  String src;
  int level;
  List<AsanaAudio> audioSources;
  List<AsanaRule> rules;
  bool isCheck;
  Duration captureTime;

  AsanaItem(id, name, block, src, level, isCheck, captureTime, {this.audioSources = const [], this.rules = const []});

  AsanaItem.fromJson(Map json)
      : id = json["id"],
        name = json["name"],
        block = json["block"],
        src = json["src"],
        level = json["level"],
        isCheck = json["isCheck"],
        captureTime = json["captureTime"] != null ? Duration(seconds: json["captureTime"]) : null,
        audioSources = json["audioSources"].map<AsanaAudio>((element) => AsanaAudio.fromJson(element)).toList(),
        rules = json["rules"] != null
            ? json["rules"].map<AsanaRule>((element) => AsanaRule.fromJson(element)).toList()
            : [];

  static AsanaVideoFragment convertToVideoFragment(AsanaItem asana, PracticePreferences preferences) {
    if (asana.src != null && asana.audioSources.length > 0) {
      String _video = asana.src;
      String _audio = _getAudioByPreferences(asana.audioSources, preferences);
      return AsanaVideoFragment(videoSrc: _video, audioSrc: _audio);
    } else {
      return null;
    }
  }
}

enum AsanaAudioVoice { male, female }

class AsanaAudio {
  String src;
  AsanaAudioVoice voice;
  bool isShort;

  AsanaAudio(src, voice, isShort);

  AsanaAudio.fromJson(Map json)
      : src = json["src"],
        voice = json["voice"] == "female" ? AsanaAudioVoice.female : AsanaAudioVoice.male,
        isShort = json["isShort"];
}

class AsanaRuleOffset {
  final int min = 0;
  final int max = 0;

  const AsanaRuleOffset(min, max);
}

class AsanaRule {
  List line;
  int angle;
  AsanaRuleOffset offset;

  AsanaRule(line, angle, {this.offset = const AsanaRuleOffset(0, 0)});

  AsanaRule.fromJson(Map json) {
    print(json["line"]);
    line = json["line"];
    angle = json["angle"];
    offset = AsanaRuleOffset(json["offset"]["min"], json["offset"]["max"]);
  }
}

class AsanaEstimationEntity {
  String chain;
  double deg;
  bool isDone;

  AsanaEstimationEntity(chain, deg, {this.isDone});
}

class AsanaVideoFragment {
  String videoSrc;
  String audioSrc;

  AsanaVideoFragment({@required this.videoSrc, @required this.audioSrc});
}

String _getAudioByPreferences(List<AsanaAudio> audios, PracticePreferences preferences) {
  AsanaAudio _currentAudio =
      audios.firstWhere((_audio) => (_audio.isShort == preferences.complexity) && (_audio.voice == preferences.voice));
  return _currentAudio.src;
}

AsanaAudioVoice convertVoiceFromString(String type) {
  switch (type) {
    case "female":
      return AsanaAudioVoice.female;
    case "male":
      return AsanaAudioVoice.male;
  }
}

String convertVoiceFromType(AsanaAudioVoice type) {
  switch (type) {
    case AsanaAudioVoice.female:
      return "female";
    case AsanaAudioVoice.male:
      return "male";
  }
}

bool convertComplexityFromString(String value) {
  return value == "full";
}

String convertComplexityFromBool(bool value) {
  return value ? "full" : "short";
}
