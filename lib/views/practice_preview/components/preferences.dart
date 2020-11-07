import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_bloc.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_event.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_state.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/select.dart';
import 'package:aum_app_build/views/shared/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewPreferences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _PreferencesHead(),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: _PreferencesMain())
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
          onPressed: () {},
        )
      ],
    );
  }
}

class _PreferencesMain extends StatelessWidget {
  Widget _buildPreferenceSelect(
      {String label,
      List<Map<String, dynamic>> options,
      dynamic selected,
      Function onChanged}) {
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
      PracticePreferencesDictionaries preferences =
          (state as PreviewIsReady).preferences;
      PracticePreferences defaults = (state as PreviewIsReady).preferenceValues;
      return Column(children: [
        _buildPreferenceSelect(
          label: "Voice",
          options: preferences.voice,
          selected: defaults.voice,
          onChanged: (option) {
            BlocProvider.of<PreviewBloc>(context).add(SetPreferences(
                updates: PracticePreferenceValue(
                    key: "voice", value: option.value)));
          },
        ),
        _buildPreferenceSelect(
          label: "Advices",
          options: preferences.complexity,
          selected: defaults.complexity,
          onChanged: (option) {
            BlocProvider.of<PreviewBloc>(context).add(SetPreferences(
                updates: PracticePreferenceValue(
                    key: "complexity", value: option.value)));
          },
        ),
        _buildPreferenceSelect(
          label: "Count type",
          options: preferences.counter,
          selected: defaults.counter,
          onChanged: (option) {
            BlocProvider.of<PreviewBloc>(context).add(SetPreferences(
                updates: PracticePreferenceValue(
                    key: "counter", value: option.value)));
          },
        ),
        _buildPreferenceSelect(
          label: "Music",
          options: preferences.music,
          selected: defaults.music,
          onChanged: (option) {
            BlocProvider.of<PreviewBloc>(context).add(SetPreferences(
                updates: PracticePreferenceValue(
                    key: "music", value: option.value)));
          },
        )
      ]);
    });
  }
}
