import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/select.dart';
import 'package:aum_app_build/views/ui/title.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class PreviewPreferences extends StatelessWidget {
  final Function onChange;
  PreviewPreferences({this.onChange});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _PreferencesHead(),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: _PreferencesMain(onChange: onChange))
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
  final Function onChange;
  _PreferencesMain({this.onChange});
  final List<Map<String, dynamic>> test = [
    {"label": "test option 1", "value": "test value 1"},
    {"label": "test option 2", "value": "test value 2"},
    {"label": "test option 3", "value": "test value 3"}
  ];
  final List<Map<String, dynamic>> _advices = [
    {
      "label": "Female - Full explanation",
      "value": {"type": "female", "complexity": "full"}
    },
    {
      "label": "Female - Short explanation",
      "value": {"type": "female", "complexity": "short"}
    },
    {
      "label": "Male - Full explanation",
      "value": {"type": "male", "complexity": "full"}
    },
    {
      "label": "Male - Short explanation",
      "value": {"type": "male", "complexity": "short"}
    },
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
              options: label == 'Advices' ? _advices : test,
              onChanged: (option) {
                onChange(option.value);
              },
            )))
        .toList();
    return Column(children: _preferencesViews);
  }
}
