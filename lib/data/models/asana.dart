import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/utils/data.dart';
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

  factory AsanaItem.fromJson(Map json) {
    DataExtractor _source = DataExtractor(json);
    return AsanaItem(
        _source.getValue("id"),
        _source.getValue("name"),
        _source.getValue("block"),
        _source.getValue("src"),
        _source.getValue("level"),
        _source.getValue("isCheck"),
        _source.getValue("captureTime"),
        rules: _source.getValue("audioSources"),
        audioSources: _source.getValue("rules"));
  }

  AsanaVideoFragment convertToVideoFragment(AsanaItem asana, PracticePreferences preferences) {
    String _video = asana.src;
    String _audio = _getAudioByPreferences(asana.audioSources, preferences);
    return AsanaVideoFragment(videoSrc: _video, audioSrc: _audio);
  }
}

enum AsanaAudioVoice { male, female }

class AsanaAudio {
  String src;
  AsanaAudioVoice voice;
  bool isShort;

  AsanaAudio(src, voice, isShort);

  factory AsanaAudio.fromJson(Map json) {
    DataExtractor _source = DataExtractor(json);
    return AsanaAudio(
      _source.getValue("src"),
      _source.getValue("voice"),
      _source.getValue("isShort"),
    );
  }
}

class AsanaRuleOffset {
  final int min = 0;
  final int max = 0;

  const AsanaRuleOffset(min, max);
}

class AsanaRule {
  List<String> line;
  double angle;
  AsanaRuleOffset offset;

  AsanaRule(line, angle, {this.offset = const AsanaRuleOffset(0, 0)});

  factory AsanaRule.fromJson(Map json) {
    DataExtractor _source = DataExtractor(json);
    return AsanaRule(
      _source.getValue("line"),
      _source.getValue("angle"),
      offset: _source.getValue("offset"),
    );
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
