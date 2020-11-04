import 'dart:async';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_event.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_state.dart';
import 'package:bloc/bloc.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {
  PreviewBloc() : super(PreviewIsLoad());
  @override
  Stream<PreviewState> mapEventToState(PreviewEvent event) async* {
    if (event is InitPreview) {
      yield* _mapPreviewToState(event);
    }
    if (event is SetPreferences) {
      yield* _mapSetPreferencesToState(event);
    }
  }

  Stream<PreviewState> _mapPreviewToState(InitPreview event) async* {
    yield PreviewIsReady(
        preferenceValues: PracticePreferences(), preview: event.preview);
  }

  Stream<PreviewState> _mapSetPreferencesToState(SetPreferences event) async* {
    (state as PreviewIsReady).updatePreferences(event.updates);
  }
}
