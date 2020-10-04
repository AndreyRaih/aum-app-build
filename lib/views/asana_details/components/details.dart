import 'package:aum_app_build/views/shared/data_row.dart';
import 'package:aum_app_build/views/shared/expanded_section.dart';
import 'package:aum_app_build/views/shared/list.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/title.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class AsanaDetails extends StatelessWidget {
  final List<String> _adivces = [
    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AumTitle(
        text: 'Parivritta Parshvakonasana',
      ),
      _DetailsSeparator(),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: AumDataRow(data: [
            {
              'label': 'Failed:',
              'value': 'Left knee, right wrist, right shoulder'
            }
          ])),
      _DetailsSeparator(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AumTitle(
            text: 'Pieces of advice',
          ),
          AumList.plain(
            list: _adivces,
          )
        ],
      ),
      _DetailsSeparator(),
      AumExpandedSection(
        label: 'Benefits',
        content: AumList.plain(
          list: _adivces,
        ),
      ),
      AumExpandedSection(
        label: 'Prohibitions',
        content: AumList.plain(
          list: _adivces,
        ),
      ),
    ]);
  }
}

class _DetailsSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
    );
  }
}
