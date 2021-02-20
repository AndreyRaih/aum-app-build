import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_bloc.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_event.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_state.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/select.dart';
import 'package:aum_app_build/views/shared/title.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewPreferences extends StatelessWidget {
  final Function(PracticePreferenceChanges) onUpdatePreferences;
  const PreviewPreferences({this.onUpdatePreferences});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _PreferencesHead(),
      Padding(padding: EdgeInsets.symmetric(vertical: 24), child: _PreferencesMain(onChange: onUpdatePreferences))
    ]);
  }
}

class _PreferencesHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AumTitle(text: 'Preferences'),
        AumSecondaryButton(
          text: 'Use last',
          onPressed: () => BlocProvider.of<PreviewBloc>(context).add(RestorePreferences()),
        )
      ],
    );
  }
}

class _PreferencesMain extends StatelessWidget {
  final Function(PracticePreferenceChanges) onChange;
  const _PreferencesMain({this.onChange});

  Widget _buildPreferenceSelect(
      {String label, List<Map<String, dynamic>> options, dynamic selected, Function onChanged}) {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: AumSelect(
          label: label,
          options: options,
          selected: selected,
          onChanged: (option) {
            onChanged(option);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewBloc, PreviewState>(builder: (context, state) {
      PracticePreferencesDictionaries preferences = (state as PreviewIsReady).preferences;
      PracticePreferences defaults = (state as PreviewIsReady).preferenceValues;
      return Column(key: UniqueKey(), children: [
        _buildPreferenceSelect(
            label: "Voice",
            options: preferences.voice.map<Map<String, dynamic>>((item) => item.toMap()).toList(),
            selected: defaults.voice,
            onChanged: (option) => onChange(PracticePreferenceChanges(key: "voice", value: option.value))),
        _buildPreferenceSelect(
            label: "Advices",
            options: preferences.complexity.map<Map<String, dynamic>>((item) => item.toMap()).toList(),
            selected: defaults.complexity,
            onChanged: (option) => onChange(PracticePreferenceChanges(key: "complexity", value: option.value))),
        AumText.regular(
          'More preferences settings will be able in extented version',
          color: AumColor.additional,
        )
      ]);
    });
  }
}
