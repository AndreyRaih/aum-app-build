import 'package:aum_app_build/data/models/practice.dart';
import 'package:aum_app_build/data/models/preferences.dart';

class PreviewEvent {
  const PreviewEvent();
}

class InitPreview extends PreviewEvent {
  final AumUserPractice preview;
  const InitPreview({this.preview});
}

class RestorePreferences extends PreviewEvent {
  const RestorePreferences();
}

class SetPreferences extends PreviewEvent {
  final PracticePreferenceChanges updates;
  const SetPreferences({this.updates});
}

class UseLastPreviewPreferences extends PreviewEvent {
  const UseLastPreviewPreferences();
}

class SavePreferences extends PreviewEvent {
  const SavePreferences();
}
