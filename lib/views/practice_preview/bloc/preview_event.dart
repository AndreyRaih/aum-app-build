import 'package:aum_app_build/data/models/preferences.dart';

class PreviewEvent {
  const PreviewEvent();
}

class InitPreview extends PreviewEvent {
  final Map preview;
  const InitPreview({this.preview});
}

class RestorePreferences extends PreviewEvent {
  const RestorePreferences();
}

class SetPreferences extends PreviewEvent {
  final PracticePreferenceValue updates;
  const SetPreferences({this.updates});
}

class UseLastPreviewPreferences extends PreviewEvent {
  const UseLastPreviewPreferences();
}

class SavePreferences extends PreviewEvent {
  const SavePreferences();
}
