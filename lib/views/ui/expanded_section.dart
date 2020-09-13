import 'package:flutter/material.dart';

class AumExpandedSection extends StatefulWidget {
  final String label;
  final bool isExpand;
  final Widget content;
  AumExpandedSection(
      {@required this.label, @required this.content, this.isExpand});

  @override
  _AumExpandedSectionState createState() => _AumExpandedSectionState();
}

class _AumExpandedSectionState extends State<AumExpandedSection> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
