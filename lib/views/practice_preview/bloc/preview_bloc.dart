import 'dart:async';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_event.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_state.dart';
import 'package:bloc/bloc.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {
  PreviewBloc() : super(PreviewState());
  @override
  Stream<PreviewState> mapEventToState(PreviewEvent event) async* {
    if (event is InitPreviewDictionaries) {
      yield* _mapInitPreferencesToState();
    }
    if (event is SetPreferences) {
      yield* _mapSetPreferencesToState(event);
    }
  }

  Stream<PreviewState> _mapInitPreferencesToState() async* {
    yield PreviewPreferencesIsReady(values: PracticePreferences());
  }

  Stream<PreviewState> _mapSetPreferencesToState(SetPreferences event) async* {
    (state as PreviewPreferencesIsReady).setNewValues(event.updates);
  }
}
