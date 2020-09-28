import 'package:aum_app_build/views/ui/list.dart';
import 'package:aum_app_build/views/ui/title.dart';
import 'package:flutter/material.dart';

class FeedbackBenefits extends StatelessWidget {
  final List<String> _adivces = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [AumTitle(text: 'Benefits'), AumList.plain(list: _adivces)],
    );
  }
}
