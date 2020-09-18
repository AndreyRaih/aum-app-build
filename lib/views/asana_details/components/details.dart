import 'package:aum_app_build/views/ui/data_row.dart';
import 'package:aum_app_build/views/ui/expanded_section.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class AsanaDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _AsanaDetailsTitle(),
      _AsanaFailsList(),
      _AsanaDetailsDescription(),
      AumExpandedSection(
        label: 'Benefits',
        content: _AsanaDetailsBenefits(),
      ),
      AumExpandedSection(
        label: 'Prohibitions',
        content: _AsanaDetailsProhibtions(),
      ),
    ]);
  }
}

class _AsanaDetailsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: AumText.bold(
          'Parivritta Parshvakonasana',
          size: 30,
        ));
  }
}

class _AsanaFailsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            border: Border.symmetric(
                vertical: BorderSide(width: 1, color: Colors.grey[300]))),
        child: AumDataRow(data: [
          {
            'label': 'Failed:',
            'value': 'Left knee, right wrist, right shoulder'
          }
        ]));
  }
}

class _AsanaDetailsDescription extends StatelessWidget
    with _AsanaDetailTextList {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
        child: Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: AumText.bold(
                      'Pieces of advice',
                      size: 24,
                      color: AumColor.accent,
                    )),
                Column(
                  children: getWidgets(),
                )
              ],
            )));
  }
}

class _AsanaDetailsBenefits extends StatelessWidget with _AsanaDetailTextList {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: getWidgets(),
    );
  }
}

class _AsanaDetailsProhibtions extends StatelessWidget
    with _AsanaDetailTextList {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: getWidgets(),
    );
  }
}

abstract class _AsanaDetailTextList {
  final List<String> _adivces = [
    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
  ];
  List<Widget> getWidgets() {
    List<Widget> _adivcesViews = _adivces
        .map((advice) => Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: AumText.medium(
                advice,
                size: 16,
                color: AumColor.additional,
              ),
            ))
        .toList();
    return _adivcesViews;
  }
}
