import 'package:aum_app_build/data/models/preferences.dart';

class PreviewState {
  const PreviewState();
}

class PreviewPreferencesIsReady extends PreviewState {
  final PracticePreferencesDictionaries preferences =
      PracticePreferencesDictionaries();
  final PracticePreferences values;
  PreviewPreferencesIsReady({this.values});

  void setNewValues(PracticePreferenceValue updates) =>
      this.values.update(updates);
}
