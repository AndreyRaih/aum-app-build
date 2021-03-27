import 'dart:async';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_state.dart';
import 'package:bloc/bloc.dart';

class PreviewCubit extends Cubit<PreviewState> {
  PreviewCubit() : super(PreviewIsLoad());

  void initPreview(preview) =>
      emit(PreviewIsReady(preferenceValues: PracticePreferences.defaultValues(), preview: preview));
  Future restorePreferences() async {
    final PracticePreferences _restoredPreferences = await PracticePreferences().restoreValues();
    emit(PreviewIsReady(preferenceValues: _restoredPreferences, preview: (state as PreviewIsReady).preview));
  }

  void setPreferences(updates) => (state as PreviewIsReady).updatePreferences(updates);
}
