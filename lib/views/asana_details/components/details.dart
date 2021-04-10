import 'package:aum_app_build/views/shared/data_row.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class AsanaDetails extends StatelessWidget {
  final String name;
  final List<Map<String, String>> descriptions;
  AsanaDetails({this.name, this.descriptions});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(bottom: SMALL_OFFSET),
        child: AumText.bold(name, size: 36),
      ),
      _DetailsSeparator(),
      Padding(padding: EdgeInsets.symmetric(vertical: 16), child: AumDataRow(data: descriptions)),
      _DetailsSeparator(),
      Padding(
        padding: EdgeInsets.symmetric(vertical: MIDDLE_OFFSET),
        child: AumText.bold(
          'Progress log',
          size: 28,
        ),
      ),
    ]);
  }
}

class _DetailsSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
    );
  }
}
