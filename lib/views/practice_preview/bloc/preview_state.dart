import 'package:aum_app_build/data/models/preferences.dart';

class PreviewState {
  const PreviewState();
}

class PreviewIsLoad extends PreviewState {
  const PreviewIsLoad();
}

class PreviewIsReady extends PreviewState {
  final PracticePreferencesDictionaries preferences =
      PracticePreferencesDictionaries();
  final PracticePreferences preferenceValues;
  final Map preview;
  PreviewIsReady({this.preferenceValues, this.preview});

  void updatePreferences(PracticePreferenceValue updates) =>
      this.preferenceValues.update(updates);
}
