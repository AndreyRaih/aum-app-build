import 'package:aum_app_build/data/models/practice.dart';
import 'package:aum_app_build/data/models/preferences.dart';

class PreviewState {
  const PreviewState();
}

class PreviewIsLoad extends PreviewState {
  const PreviewIsLoad();
}

class PreviewIsReady extends PreviewState {
  final PracticePreferencesDictionaries preferences = PracticePreferencesDictionaries();
  final PracticePreferences preferenceValues;
  final AumUserPractice preview;
  PreviewIsReady({this.preferenceValues, this.preview});

  void updatePreferences(PracticePreferenceChanges updates) => this.preferenceValues.update(updates);
}
