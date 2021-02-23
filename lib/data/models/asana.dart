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
  List<AsanaRule> rules;
  bool isCheck;
  Duration captureTime;

  AsanaItem(this.id, this.name, this.block, this.src, this.level, this.isCheck, this.captureTime,
      {this.audioSources = const [], this.rules = const []});

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
    String _getAudioByPreferences(List<AsanaAudio> audio, PracticePreferences preferences) => audio
        .firstWhere((_audio) => (_audio.isShort == preferences.complexity) && (_audio.voice == preferences.voice))
        ?.src;
    if (asana.src != null && asana.audioSources.length > 0) {
      String _video = asana.src;
      String _audio = _getAudioByPreferences(asana.audioSources, preferences);
      return AsanaVideoFragment(videoSrc: _video, audioSrc: _audio);
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

class AsanaRuleOffset {
  final int min = 0;
  final int max = 0;

  const AsanaRuleOffset(min, max);
}

class AsanaRule {
  List line;
  int angle;
  AsanaRuleOffset offset;

  AsanaRule(this.line, this.angle, {this.offset = const AsanaRuleOffset(0, 0)});

  AsanaRule.fromJson(Map json) {
    this.line = json["line"];
    this.angle = json["angle"];
    this.offset = AsanaRuleOffset(json["offset"]["min"], json["offset"]["max"]);
  }
}

class AsanaEstimationResultItem {
  String chain;
  double deg;
  bool isDone;

  AsanaEstimationResultItem(this.chain, this.deg, {this.isDone = false});
}

class AsanaEstimationResult {
  String name;
  String block;
  List<AsanaEstimationResultItem> result;

  AsanaEstimationResult(this.name, this.block, this.result);

  toMap() {
    return {
      "name": name,
      "block": block,
      "result": result.map((e) => {"chain": e.chain, "deg": e.deg, "isDone": e.isDone}).toList()
    };
  }
}

class AsanaVideoFragment {
  String videoSrc;
  String audioSrc;

  AsanaVideoFragment({@required this.videoSrc, @required this.audioSrc});
}
