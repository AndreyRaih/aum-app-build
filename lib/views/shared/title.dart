import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class AumTitle extends StatelessWidget {
  final String text;
  AumTitle({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: AumText.bold(text, size: 28));
  }
}
