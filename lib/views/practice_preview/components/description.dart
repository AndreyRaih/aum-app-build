import 'package:aum_app_build/views/shared/data_row.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class PreviewDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(bottom: 16), child: _MainPart()),
        Padding(padding: EdgeInsets.only(bottom: 24), child: _ShortTerm())
      ],
    );
  }
}

class _MainPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: EdgeInsets.only(bottom: 8),
          child: AumText.bold(
            'Stress relief practice',
            size: 32,
          )),
      AumText.regular(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare pretium placerat ut platea. Purus blandit integer sagittis massa vel est hac.',
        size: 16,
        color: AumColor.additional,
      )
    ]);
  }
}

class _ShortTerm extends StatelessWidget {
  final List<Map<String, dynamic>> _data = [
    {'label': 'Time', 'value': '34 m'},
    {'label': 'Calories', 'value': '326'},
    {'label': 'Includes', 'value': 'Balances, standing'}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(width: 1, color: Colors.grey[300]))),
      child: AumDataRow(
        data: _data,
      ),
    );
  }
}
