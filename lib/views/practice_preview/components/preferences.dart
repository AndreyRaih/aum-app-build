import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/select.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class PreviewPreferences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: EdgeInsets.only(bottom: 16), child: _PreferencesHead()),
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
        AumText.bold(
          'Preferences',
          size: 28,
        ),
        AumSecondaryButton(
          text: 'Use last',
          onPressed: () {},
        )
      ],
    );
  }
}

class _PreferencesMain extends StatelessWidget {
  final List<Map<String, dynamic>> test = [
    {"label": "test option 1", "value": "test value 1"},
    {"label": "test option 2", "value": "test value 2"},
    {"label": "test option 3", "value": "test value 3"}
  ];

  final List<String> preferences = [
    "Practice time",
    "Advices",
    "Count type",
    "Music"
  ];
  @override
  Widget build(BuildContext context) {
    final List<Widget> _preferencesViews = preferences
        .map((label) => Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AumSelect(
              label: label,
              options: test,
              onChanged: (option) {
                print(option.value);
              },
            )))
        .toList();
    return Column(children: _preferencesViews);
  }
}
